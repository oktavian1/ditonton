import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';

abstract class MovieGetPopularState extends Equatable {
  const MovieGetPopularState();

  @override
  List<Object?> get props => [];
}

class MoviePopularEmpty extends MovieGetPopularState {}

class MoviePopularLoading extends MovieGetPopularState {}

class MoviePopularError extends MovieGetPopularState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object?> get props => [message];
}

class MoviePopularHasData extends MovieGetPopularState {
  final List<Movie> movies;

  const MoviePopularHasData(this.movies);

  @override
  List<Object?> get props => [movies];
}
