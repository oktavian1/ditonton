import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';

abstract class MovieGetNowPlayingState extends Equatable {
  const MovieGetNowPlayingState();

  @override
  List<Object?> get props => [];
}

class MovieGetNowPlayingEmpty extends MovieGetNowPlayingState {}

class MovieGetNowPlayingLoading extends MovieGetNowPlayingState {}

class MovieGetNowPlayingError extends MovieGetNowPlayingState {
  final String message;

  const MovieGetNowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieGetNowPlayingHasData extends MovieGetNowPlayingState {
  final List<Movie> movies;

  const MovieGetNowPlayingHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
