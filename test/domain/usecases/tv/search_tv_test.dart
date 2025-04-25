import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvRepository();
    usecase = SearchTv(mockMovieRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = 'naruto';

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTvs(tQuery))
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvs));
  });
}
