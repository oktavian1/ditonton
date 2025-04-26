import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';

abstract class MovieGetTopRatedState extends Equatable {
  const MovieGetTopRatedState();

  @override
  List<Object?> get props => [];
}

class MovieGetTopRatedEmpty extends MovieGetTopRatedState {}

class MovieGetTopRatedLoading extends MovieGetTopRatedState {}

class MovieGetTopRatedError extends MovieGetTopRatedState {
  final String message;

  const MovieGetTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieGetTopRatedHasData extends MovieGetTopRatedState {
  final List<Movie> movies;

  const MovieGetTopRatedHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
