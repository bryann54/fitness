// lib/features/community/domain/usecases/get_connections_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/data/models/user_connection_model.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetConnectionsUsecase
    implements UseCase<List<UserConnectionModel>, NoParams> {
  final CommunityRepository _repo;

  GetConnectionsUsecase(this._repo);

  @override
  Future<Either<Failure, List<UserConnectionModel>>> call(
      NoParams params) async {
    return await _repo.getConnections();
  }
}
