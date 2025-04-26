import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

abstract class TvOnAirState extends Equatable {
  const TvOnAirState();

  @override
  List<Object?> get props => [];
}

class TvOnAirEmpty extends TvOnAirState {}

class TvOnAirLoading extends TvOnAirState {}

class TvOnAirError extends TvOnAirState {
  final String message;

  const TvOnAirError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvOnAirHasData extends TvOnAirState {
  final List<Tv> tvs;

  const TvOnAirHasData(this.tvs);

  @override
  List<Object?> get props => [tvs];
}
