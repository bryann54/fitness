// lib/features/onboarding/presentation/bloc/onboarding_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness/common/helpers/base_usecase.dart';
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart';
import 'package:fitness/features/onboarding/domain/usecases/get_fitness_profile_usecase.dart';
import 'package:fitness/features/onboarding/domain/usecases/save_fitness_profile_usecase.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SaveFitnessProfileUsecase _saveProfileUsecase;
  final GetFitnessProfileUsecase _getProfileUsecase;

  OnboardingBloc(this._saveProfileUsecase, this._getProfileUsecase)
      : super(OnboardingInitial()) {
    on<SubmitProfileEvent>(_mapSubmitProfileEventToState);
    on<CheckProfileStatusEvent>(_mapCheckProfileStatusEventToState);
  }

  FutureOr<void> _mapSubmitProfileEventToState(
      SubmitProfileEvent event, Emitter<OnboardingState> emit) async {
    emit(OnboardingSubmissionInProgress());

    final result = await _saveProfileUsecase.call(event.profileData);

    emit(
      result.fold(
        (failure) => OnboardingFailure(
            message: 'Failed to save profile: ${failure.toString()}'),
        (_) => OnboardingSubmissionSuccess(),
      ),
    );
  }

  FutureOr<void> _mapCheckProfileStatusEventToState(
      CheckProfileStatusEvent event, Emitter<OnboardingState> emit) async {
    emit(OnboardingProfileLoading());

    final result = await _getProfileUsecase.call(const NoParams());

    emit(
      result.fold(
        (failure) => OnboardingFailure(
            message: 'Failed to check profile status: ${failure.toString()}'),
        (profile) {
          if (profile != null) {
            // Profile found, onboarding complete
            return OnboardingProfileLoaded(profile: profile);
          } else {
            // Profile not found, onboarding required
            return OnboardingRequired();
          }
        },
      ),
    );
  }
}
