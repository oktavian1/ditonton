import 'package:ditonton/domain/usecases/tv_usecase/search_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_bloc/tv_search_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_search_bloc/tv_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTvs;

  TvSearchBloc(this._searchTvs) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvs.execute(query);

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
