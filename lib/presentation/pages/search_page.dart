import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    setState(() {
      _query = query;
    });

    if (_tabController.index == 0) {
      Provider.of<MovieSearchNotifier>(context, listen: false)
          .fetchMovieSearch(query);
    } else {
      Provider.of<TvSearchNotifier>(context, listen: false)
          .fetchTvsSearch(query);
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
    final movieSearchNotifier = Provider.of<MovieSearchNotifier>(context);
    final tvSearchNotifier = Provider.of<TvSearchNotifier>(context);

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
                    _buildMovieResult(movieSearchNotifier),
                    _buildTvResult(tvSearchNotifier),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieResult(MovieSearchNotifier notifier) {
    if (notifier.state == RequestState.Loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (notifier.state == RequestState.Loaded) {
      return ListView.builder(
        itemCount: notifier.searchResult.length,
        itemBuilder: (context, index) {
          final movie = notifier.searchResult[index];
          return MediaCardList(item: movie);
        },
      );
    } else {
      return const Center(child: Text('No results'));
    }
  }

  Widget _buildTvResult(TvSearchNotifier notifier) {
    if (notifier.state == RequestState.Loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (notifier.state == RequestState.Loaded) {
      return ListView.builder(
        itemCount: notifier.searchResult.length,
        itemBuilder: (context, index) {
          final tv = notifier.searchResult[index];
          return MediaCardList(item: tv);
        },
      );
    } else {
      return const Center(child: Text('No results'));
    }
  }
}
