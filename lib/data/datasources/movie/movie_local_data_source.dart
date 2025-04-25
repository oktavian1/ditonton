import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/watchlist_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable movie);
  Future<String> removeWatchlist(WatchlistTable movie);
  Future<WatchlistTable?> getMovieById(int id, String type);
  Future<List<WatchlistTable>> getWatchlistMovies(String type);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getMovieById(int id, String type) async {
    final result = await databaseHelper.getMovieById(id, type);
    if (result != null) {
      return WatchlistTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistMovies(String type) async {
    final result = await databaseHelper.getWatchlistMovies(type);
    return result.map((data) => WatchlistTable.fromJson(data)).toList();
  }
}
