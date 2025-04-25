import 'package:ditonton/domain/usecases/movie_usecase/search_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_bloc/search_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    });
  }
}
