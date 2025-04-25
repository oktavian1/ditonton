import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_bloc/search_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_bloc/search_event.dart'
    as movieEvent;
import 'package:ditonton/presentation/provider/movie_provider/movie_search_bloc/search_state.dart'
    as movieState;
import 'package:ditonton/presentation/provider/tv_provider/tv_search_bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_bloc/tv_search_event.dart'
    as tvEvent;
import 'package:ditonton/presentation/provider/tv_provider/tv_search_bloc/tv_search_state.dart'
    as tvState;
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _controller.clear(); // reset input
  }

  void _onSearch(String query) {
    if (_tabController.index == 0) {
      context.read<SearchBloc>().add(movieEvent.OnQueryChanged(query));
    } else {
      context.read<TvSearchBloc>().add(tvEvent.OnQueryChanged(query));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Movies'),
              Tab(text: 'TV Series'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onSubmitted: _onSearch,
                onChanged: (query) {
                  if (_tabController.index == 0) {
                    context
                        .read<SearchBloc>()
                        .add(movieEvent.OnQueryChanged(query));
                  } else {
                    context
                        .read<TvSearchBloc>()
                        .add(tvEvent.OnQueryChanged(query));
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search title...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text('Search Result', style: kHeading6),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMovieResult(),
                    _buildTvResult(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieResult() {
    return BlocBuilder<SearchBloc, movieState.SearchState>(
      builder: (context, state) {
        if (state is movieState.SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is movieState.SearchHasData) {
          final result = state.result;
          return ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              final movie = result[index];
              return MediaCardList(item: movie);
            },
          );
        } else if (state is movieState.SearchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No results'));
        }
      },
    );
  }

  Widget _buildTvResult() {
    return BlocBuilder<TvSearchBloc, tvState.TvSearchState>(
      builder: (context, state) {
        if (state is tvState.SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is tvState.SearchHasData) {
          final result = state.result;
          return ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, index) {
              final movie = result[index];
              return MediaCardList(item: movie);
            },
          );
        } else if (state is tvState.SearchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No results'));
        }
      },
    );
  }
}
