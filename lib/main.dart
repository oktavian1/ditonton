import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/on_air_tv_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_now_playing_movies/movie_get_now_playing_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_bloc/search_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_top_rated_bloc/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();
  await locator.allReady();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieGetNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieGetPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieGetTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvOnAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailActionBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailActionBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case PopularTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            case OnAirTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => OnAirTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
