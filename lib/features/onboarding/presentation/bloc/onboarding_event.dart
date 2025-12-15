part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
  @override
  List<Object> get props => [];
}

class SubmitProfileEvent extends OnboardingEvent {
  final FitnessProfileModel profileData;
  const SubmitProfileEvent({required this.profileData});
  @override
  List<Object> get props => [profileData];
}

// Checks if the user's profile document exists in Firestore
class CheckProfileStatusEvent extends OnboardingEvent {}
