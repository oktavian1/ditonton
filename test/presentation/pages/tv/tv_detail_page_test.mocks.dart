// Mocks generated by Mockito 5.4.4 from annotations
// in ditonton/test/presentation/pages/tv/tv_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:ditonton/domain/usecases/tv_usecase/get_recomendation_tv.dart'
    as _i3;
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/tv_usecase/get_watch_list_tv_status.dart'
    as _i5;
import 'package:ditonton/domain/usecases/tv_usecase/remove_tv.dart' as _i7;
import 'package:ditonton/domain/usecases/tv_usecase/save_tv.dart' as _i6;
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_bloc.dart'
    as _i13;
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_event.dart'
    as _i14;
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_state.dart'
    as _i8;
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_bloc.dart'
    as _i9;
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_event.dart'
    as _i11;
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_state.dart'
    as _i4;
import 'package:flutter_bloc/flutter_bloc.dart' as _i12;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvDetail_0 extends _i1.SmartFake implements _i2.GetTvDetail {
  _FakeGetTvDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetRecomendationTv_1 extends _i1.SmartFake
    implements _i3.GetRecomendationTv {
  _FakeGetRecomendationTv_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetailState_2 extends _i1.SmartFake implements _i4.TvDetailState {
  _FakeTvDetailState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchListTvStatus_3 extends _i1.SmartFake
    implements _i5.GetWatchListTvStatus {
  _FakeGetWatchListTvStatus_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveTv_4 extends _i1.SmartFake implements _i6.SaveTv {
  _FakeSaveTv_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveTv_5 extends _i1.SmartFake implements _i7.RemoveTv {
  _FakeRemoveTv_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetailActionState_6 extends _i1.SmartFake
    implements _i8.TvDetailActionState {
  _FakeTvDetailActionState_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailBloc extends _i1.Mock implements _i9.TvDetailBloc {
  MockTvDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail => (super.noSuchMethod(
        Invocation.getter(#getTvDetail),
        returnValue: _FakeGetTvDetail_0(
          this,
          Invocation.getter(#getTvDetail),
        ),
      ) as _i2.GetTvDetail);

  @override
  _i3.GetRecomendationTv get getRecomendationTv => (super.noSuchMethod(
        Invocation.getter(#getRecomendationTv),
        returnValue: _FakeGetRecomendationTv_1(
          this,
          Invocation.getter(#getRecomendationTv),
        ),
      ) as _i3.GetRecomendationTv);

  @override
  _i4.TvDetailState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTvDetailState_2(
          this,
          Invocation.getter(#state),
        ),
      ) as _i4.TvDetailState);

  @override
  _i10.Stream<_i4.TvDetailState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i10.Stream<_i4.TvDetailState>.empty(),
      ) as _i10.Stream<_i4.TvDetailState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i11.TvDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i11.TvDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i4.TvDetailState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i11.TvDetailEvent>(
    _i12.EventHandler<E, _i4.TvDetailState>? handler, {
    _i12.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i12.Transition<_i11.TvDetailEvent, _i4.TvDetailState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  void onChange(_i12.Change<_i4.TvDetailState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TvDetailActionBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailActionBloc extends _i1.Mock
    implements _i13.TvDetailActionBloc {
  MockTvDetailActionBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.GetWatchListTvStatus get getWatchListTvStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchListTvStatus),
        returnValue: _FakeGetWatchListTvStatus_3(
          this,
          Invocation.getter(#getWatchListTvStatus),
        ),
      ) as _i5.GetWatchListTvStatus);

  @override
  _i6.SaveTv get saveTv => (super.noSuchMethod(
        Invocation.getter(#saveTv),
        returnValue: _FakeSaveTv_4(
          this,
          Invocation.getter(#saveTv),
        ),
      ) as _i6.SaveTv);

  @override
  _i7.RemoveTv get removeTv => (super.noSuchMethod(
        Invocation.getter(#removeTv),
        returnValue: _FakeRemoveTv_5(
          this,
          Invocation.getter(#removeTv),
        ),
      ) as _i7.RemoveTv);

  @override
  _i8.TvDetailActionState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTvDetailActionState_6(
          this,
          Invocation.getter(#state),
        ),
      ) as _i8.TvDetailActionState);

  @override
  _i10.Stream<_i8.TvDetailActionState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i10.Stream<_i8.TvDetailActionState>.empty(),
      ) as _i10.Stream<_i8.TvDetailActionState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i14.TvDetailActionEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i14.TvDetailActionEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i8.TvDetailActionState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i14.TvDetailActionEvent>(
    _i12.EventHandler<E, _i8.TvDetailActionState>? handler, {
    _i12.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i12.Transition<_i14.TvDetailActionEvent, _i8.TvDetailActionState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i10.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  void onChange(_i12.Change<_i8.TvDetailActionState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
