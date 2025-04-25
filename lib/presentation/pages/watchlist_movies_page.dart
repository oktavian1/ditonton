import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/movie_provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/watchlist_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/media_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistMovies();
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
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistMovies();
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
    return Consumer<WatchlistMovieNotifier>(
      builder: (context, data, child) {
        if (data.watchlistState == RequestState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (data.watchlistState == RequestState.Loaded) {
          if (data.watchlistMovies.isEmpty) {
            return const Center(child: Text('No movies in watchlist'));
          }
          return ListView.builder(
            itemCount: data.watchlistMovies.length,
            itemBuilder: (context, index) {
              final movie = data.watchlistMovies[index];
              return MediaCardList(item: movie);
            },
          );
        } else {
          return Center(child: Text(data.message));
        }
      },
    );
  }

  Widget _buildWatchlistTv() {
    return Consumer<WatchlistTvNotifier>(
      builder: (context, data, child) {
        if (data.watchlistTvState == RequestState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (data.watchlistTvState == RequestState.Loaded) {
          if (data.watchlistTv.isEmpty) {
            return const Center(child: Text('No TV series in watchlist'));
          }
          return ListView.builder(
            itemCount: data.watchlistTv.length,
            itemBuilder: (context, index) {
              final tv = data.watchlistTv[index];
              return MediaCardList(item: tv);
            },
          );
        } else {
          return Center(child: Text(data.message));
        }
      },
    );
  }
}
