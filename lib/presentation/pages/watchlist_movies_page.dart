import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_watchlist_bloc/movie_watchlist_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_watchlist_bloc/movie_watchlist_state.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_state.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with SingleTickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      context.read<TvWatchlistBloc>().add(FetchTvWatchlist());
      context.read<MovieWatchlistBloc>().add(FetchWatchListMovies());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<TvWatchlistBloc>().add(FetchTvWatchlist());
    context.read<MovieWatchlistBloc>().add(FetchWatchListMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Movies'),
            Tab(text: 'TV Series'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWatchlistMovies(),
          _buildWatchlistTv(),
        ],
      ),
    );
  }

  Widget _buildWatchlistMovies() {
    return BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieWatchlistHasData) {
          if (state.movies.isEmpty)
            return Center(child: Text('Watchlist is empty'));
          return ListView.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MediaCardList(item: movie);
            },
          );
        } else if (state is MovieWatchlistError) {
          return Center(child: Text(state.message));
        } else if (state is MovieWatchlistEmpty) {
          return Center(child: Text('Watchlist is empty'));
        } else {
          return Text('Failed');
        }
      },
    );
  }

  Widget _buildWatchlistTv() {
    return BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
      builder: (context, state) {
        if (state is TvWatchlistLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvWatchlistHasData) {
          if (state.tvs.isEmpty)
            return Center(child: Text('Watchlist is empty'));
          return ListView.builder(
            itemCount: state.tvs.length,
            itemBuilder: (context, index) {
              final tv = state.tvs[index];
              return MediaCardList(item: tv);
            },
          );
        } else if (state is TvWatchlistError) {
          return Center(child: Text(state.message));
        } else {
          return Text('Failed');
        }
      },
    );
  }
}
