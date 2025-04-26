import 'package:equatable/equatable.dart';

abstract class MovieDetailActionState extends Equatable {
  const MovieDetailActionState();

  @override
  List<Object?> get props => [];
}

class MMovieDetailActionEmpty extends MovieDetailActionState {}

class MovieDetailActionLoading extends MovieDetailActionState {}

class MovieDetailActionError extends MovieDetailActionState {
  final String message;

  const MovieDetailActionError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieDetailActionMessage extends MovieDetailActionState {
  final String message;

  const MovieDetailActionMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieWatchlistStatusChanged extends MovieDetailActionState {
  final bool isAdded;

  const MovieWatchlistStatusChanged(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}
