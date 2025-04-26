import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object?> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvWatchlistHasData extends TvWatchlistState {
  final List<Tv> tvs;

  const TvWatchlistHasData(this.tvs);

  @override
  List<Object?> get props => [tvs];
}
