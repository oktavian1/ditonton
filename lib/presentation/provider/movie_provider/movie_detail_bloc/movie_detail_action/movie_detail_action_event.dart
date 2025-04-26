import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailActionEvent extends Equatable {
  const MovieDetailActionEvent();

  @override
  List<Object?> get props => [];
}

class AddToWatchlist extends MovieDetailActionEvent {
  final MovieDetail movieDetail;

  const AddToWatchlist(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class RemoveFromWatchlist extends MovieDetailActionEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlist(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class LoadWatchlistStatus extends MovieDetailActionEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}
