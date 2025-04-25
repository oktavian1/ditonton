import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecase/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_on_air_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_recomendation_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watch_list_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/remove_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/save_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/search_tv.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie_provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_notifer.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_on_air_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_popular_notifer.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/tv_provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListNotifier(
      getPopularTv: locator(),
      getTopRatedTv: locator(),
      getOnAirTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularNotifer(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvTopRatedNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvOnAirNotifier(
      getOnAirTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getRecomendationTv: locator(),
      saveTv: locator(),
      removeTv: locator(),
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //usecase tv
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetOnAirTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetRecomendationTv(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => SaveTv(locator()));
  locator.registerLazySingleton(() => RemoveTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
