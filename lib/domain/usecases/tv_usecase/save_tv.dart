import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class SaveTv {
  final TvRepository repository;

  SaveTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.saveTvlist(movie);
  }
}
