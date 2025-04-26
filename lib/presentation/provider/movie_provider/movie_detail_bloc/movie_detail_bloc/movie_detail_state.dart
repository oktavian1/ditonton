import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movie;
  final List<Movie> recommendations;

  const MovieDetailHasData({
    required this.movie,
    required this.recommendations,
  });

  @override
  List<Object?> get props => [movie, recommendations];
}
