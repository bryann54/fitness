// lib/features/onboarding/presentation/bloc/onboarding_state.dart (part of onboarding_bloc.dart)

part of 'onboarding_bloc.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();
  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

// States for profile status check
class OnboardingProfileLoading extends OnboardingState {}

class OnboardingRequired
    extends OnboardingState {} // Profile not found (needs onboarding)

// States for profile submission
class OnboardingSubmissionInProgress extends OnboardingState {}

class OnboardingSubmissionSuccess extends OnboardingState {}

class OnboardingFailure extends OnboardingState {
  final String message;
  const OnboardingFailure({required this.message});
  @override
  List<Object> get props => [message];
}

class OnboardingProfileLoaded extends OnboardingState {
  final FitnessProfileModel profile;
  const OnboardingProfileLoaded({required this.profile});
  @override
  List<Object> get props => [profile];
}
