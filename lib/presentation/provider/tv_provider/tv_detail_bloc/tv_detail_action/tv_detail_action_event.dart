import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailActionEvent extends Equatable {
  const TvDetailActionEvent();

  @override
  List<Object?> get props => [];
}

class AddToWatchlist extends TvDetailActionEvent {
  final TvDetail tvDetail;

  const AddToWatchlist(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class RemoveFromWatchlist extends TvDetailActionEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchlist(this.tvDetail);

  @override
  List<Object?> get props => [tvDetail];
}

class LoadWatchlistStatus extends TvDetailActionEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}
