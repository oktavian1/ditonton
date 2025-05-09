import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> movies;

  const MovieWatchlistHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
