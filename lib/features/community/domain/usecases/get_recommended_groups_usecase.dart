// lib/features/community/domain/usecases/get_recommended_groups_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/core/errors/failures.dart';
import 'package:fitness/features/community/data/models/community_group_model.dart';
import 'package:fitness/features/community/domain/repositories/community_repository.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRecommendedGroupsUsecase
    implements UseCase<List<CommunityGroupModel>, FitnessProfileModel> {
  final CommunityRepository _repo;

  GetRecommendedGroupsUsecase(this._repo);

  @override
  Future<Either<Failure, List<CommunityGroupModel>>> call(
    FitnessProfileModel profile,
  ) async {
    return await _repo.getRecommendedGroups(profile);
  }
}
