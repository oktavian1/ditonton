import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_state.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_state.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_state.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

// test/helpers/fake_bloc.dart
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieDetailActionEvent extends Fake
    implements MovieDetailActionEvent {}

class FakeMovieDetailActionState extends Fake
    implements MovieDetailActionState {}

class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvDetailState extends Fake implements TvDetailState {}

class FakeTvDetailActionEvent extends Fake implements TvDetailActionEvent {}

class FakeTvDetailActionState extends Fake implements TvDetailActionState {}

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRepository,
  TvRemoteDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
