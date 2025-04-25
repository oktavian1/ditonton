import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/generic/media_item.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/on_air_tv_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_notifer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final movieNotifier =
          Provider.of<MovieListNotifier>(context, listen: false);
      final tvNotifier = Provider.of<TvListNotifier>(context, listen: false);

      movieNotifier.fetchNowPlayingMovies();
      movieNotifier.fetchPopularMovies();
      movieNotifier.fetchTopRatedMovies();
      tvNotifier.fetchTvPopularTv();
      tvNotifier.fetchTopRatedTv();
      tvNotifier.fetchOnAirTv();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.white),
              Center(child: Text('MOVIE SERIES', style: kHeading6)),
              Divider(color: Colors.white),
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MediaList<Movie>(
                    items: data.nowPlayingMovies.whereType<Movie>().toList(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MediaList<Movie>(
                    items: data.popularMovies.whereType<Movie>().toList(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MediaList<Movie>(
                    items: data.topRatedMovies.whereType<Movie>().toList(),
                  );
                } else {
                  return Text('Failed');
                }
              }),
              Divider(color: Colors.white),
              Center(child: Text('TV SERIES', style: kHeading6)),
              Divider(color: Colors.white),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularTvsPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == RequestState.Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return MediaList<Tv>(
                    items: data.popularTv.whereType<Tv>().toList(),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
              //pembatas
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedTvPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvState;
                if (state == RequestState.Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return MediaList<Tv>(
                    items: data.topRatedTv.whereType<Tv>().toList(),
                  );
                } else {
                  return const Text('Failed');
                }
              }),

              //pembatas
              _buildSubHeading(
                title: 'On Air TV',
                onTap: () => Navigator.pushNamed(
                  context,
                  OnAirTvPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.onAirTvState;
                if (state == RequestState.Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state == RequestState.Loaded) {
                  return MediaList<Tv>(
                    items: data.onAirTv.whereType<Tv>().toList(),
                  );
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MediaList<T extends MediaItem> extends StatelessWidget {
  final List<T> items;

  const MediaList({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                if (item is Movie) {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.ROUTE_NAME,
                    arguments: item.id,
                  );
                } else if (item is Tv) {
                  Navigator.pushNamed(
                    context,
                    TvDetailPage.ROUTE_NAME,
                    arguments: item.id,
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: item.posterPath != null
                      ? '$BASE_IMAGE_URL${item.posterPath}'
                      : '',
                  width: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/no_image.png',
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie?> movies;
  final List<Tv?> tv;

  MovieList(this.movies, this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isMovieList = movies.isNotEmpty;
          final item = isMovieList ? movies[index] : tv[index];
          final id = isMovieList ? (item as Movie).id : (item as Tv).id;
          final posterPath = isMovieList
              ? (item as Movie).posterPath
              : (item as Tv).posterPath;

          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.isNotEmpty ? movies.length : tv.length,
      ),
    );
  }
}
