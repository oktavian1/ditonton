import 'package:equatable/equatable.dart';

abstract class TvDetailActionState extends Equatable {
  const TvDetailActionState();

  @override
  List<Object?> get props => [];
}

class TvDetailActionEmpty extends TvDetailActionState {}

class TvDetailActionLoading extends TvDetailActionState {}

class TvDetailActionError extends TvDetailActionState {
  final String message;

  const TvDetailActionError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvDetailActionMessage extends TvDetailActionState {
  final String message;

  const TvDetailActionMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class TvDetailActionStatusChanged extends TvDetailActionState {
  final bool isAdded;

  const TvDetailActionStatusChanged(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}
