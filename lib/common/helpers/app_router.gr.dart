// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i32;
import 'package:fitness/features/account/presentation/pages/account_screen.dart'
    as _i1;
import 'package:fitness/features/account/presentation/pages/edit_profile_screen.dart'
    as _i8;
import 'package:fitness/features/account/presentation/pages/help_support_screen.dart'
    as _i15;
import 'package:fitness/features/account/presentation/pages/tips_tricks_screen.dart'
    as _i26;
import 'package:fitness/features/auth/presentation/pages/get_started_screen.dart'
    as _i13;
import 'package:fitness/features/auth/presentation/pages/login_screen.dart'
    as _i16;
import 'package:fitness/features/auth/presentation/pages/register_screen.dart'
    as _i21;
import 'package:fitness/features/auth/presentation/pages/splash_screen.dart'
    as _i24;
import 'package:fitness/features/community/presentation/pages/community_page.dart'
    as _i6;
import 'package:fitness/features/meals/presentation/pages/meals_page.dart'
    as _i18;
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart'
    as _i34;
import 'package:fitness/features/onboarding/presentation/pages/age_screen.dart'
    as _i2;
import 'package:fitness/features/onboarding/presentation/pages/all_suppliments_screen.dart'
    as _i4;
import 'package:fitness/features/onboarding/presentation/pages/calories_screen.dart'
    as _i5;
import 'package:fitness/features/onboarding/presentation/pages/diet_pref_screen.dart'
    as _i7;
import 'package:fitness/features/onboarding/presentation/pages/exercise_pref_screen.dart'
    as _i9;
import 'package:fitness/features/onboarding/presentation/pages/experience_screen.dart'
    as _i10;
import 'package:fitness/features/onboarding/presentation/pages/fitness_level_screen.dart'
    as _i11;
import 'package:fitness/features/onboarding/presentation/pages/gender_screen.dart'
    as _i12;
import 'package:fitness/features/onboarding/presentation/pages/goal_screen.dart'
    as _i14;
import 'package:fitness/features/onboarding/presentation/pages/onboarding_complete_screen.dart'
    as _i19;
import 'package:fitness/features/onboarding/presentation/pages/physical_limitations_screen.dart'
    as _i20;
import 'package:fitness/features/onboarding/presentation/pages/sleep_quality_screen.dart'
    as _i22;
import 'package:fitness/features/onboarding/presentation/pages/specific_supp_screen.dart'
    as _i23;
import 'package:fitness/features/onboarding/presentation/pages/supliments_screen.dart'
    as _i25;
import 'package:fitness/features/onboarding/presentation/pages/weight_screen.dart'
    as _i27;
import 'package:fitness/features/onboarding/presentation/pages/workouts_per_week_screen.dart'
    as _i31;
import 'package:fitness/features/workouts/data/models/workout_model.dart'
    as _i35;
import 'package:fitness/features/workouts/presentation/pages/all_exercises_page.dart'
    as _i3;
import 'package:fitness/features/workouts/presentation/pages/workout_detail_page.dart'
    as _i28;
import 'package:fitness/features/workouts/presentation/pages/workout_schedule_page.dart'
    as _i29;
import 'package:fitness/features/workouts/presentation/pages/workouts_page.dart'
    as _i30;
import 'package:fitness/main_screen.dart' as _i17;
import 'package:flutter/material.dart' as _i33;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i32.PageRouteInfo<void> {
  const AccountRoute({List<_i32.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountScreen();
    },
  );
}

/// generated route for
/// [_i2.AgeScreen]
class AgeRoute extends _i32.PageRouteInfo<AgeRouteArgs> {
  AgeRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          AgeRoute.name,
          args: AgeRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'AgeRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AgeRouteArgs>();
      return _i2.AgeScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class AgeRouteArgs {
  const AgeRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'AgeRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i3.AllExercisesPage]
class AllExercisesRoute extends _i32.PageRouteInfo<AllExercisesRouteArgs> {
  AllExercisesRoute({
    _i33.Key? key,
    required List<_i35.WorkoutModel> workouts,
    required dynamic profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          AllExercisesRoute.name,
          args: AllExercisesRouteArgs(
            key: key,
            workouts: workouts,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'AllExercisesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllExercisesRouteArgs>();
      return _i3.AllExercisesPage(
        key: args.key,
        workouts: args.workouts,
        profile: args.profile,
      );
    },
  );
}

class AllExercisesRouteArgs {
  const AllExercisesRouteArgs({
    this.key,
    required this.workouts,
    required this.profile,
  });

  final _i33.Key? key;

  final List<_i35.WorkoutModel> workouts;

  final dynamic profile;

  @override
  String toString() {
    return 'AllExercisesRouteArgs{key: $key, workouts: $workouts, profile: $profile}';
  }
}

/// generated route for
/// [_i4.AllSupplementsScreen]
class AllSupplementsRoute extends _i32.PageRouteInfo<AllSupplementsRouteArgs> {
  AllSupplementsRoute({
    _i33.Key? key,
    required List<String> initialSelection,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          AllSupplementsRoute.name,
          args: AllSupplementsRouteArgs(
            key: key,
            initialSelection: initialSelection,
          ),
          initialChildren: children,
        );

  static const String name = 'AllSupplementsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllSupplementsRouteArgs>();
      return _i4.AllSupplementsScreen(
        key: args.key,
        initialSelection: args.initialSelection,
      );
    },
  );
}

class AllSupplementsRouteArgs {
  const AllSupplementsRouteArgs({
    this.key,
    required this.initialSelection,
  });

  final _i33.Key? key;

  final List<String> initialSelection;

  @override
  String toString() {
    return 'AllSupplementsRouteArgs{key: $key, initialSelection: $initialSelection}';
  }
}

/// generated route for
/// [_i5.CaloriesScreen]
class CaloriesRoute extends _i32.PageRouteInfo<CaloriesRouteArgs> {
  CaloriesRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          CaloriesRoute.name,
          args: CaloriesRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'CaloriesRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CaloriesRouteArgs>();
      return _i5.CaloriesScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class CaloriesRouteArgs {
  const CaloriesRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'CaloriesRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i6.CommunityPage]
class CommunityRoute extends _i32.PageRouteInfo<void> {
  const CommunityRoute({List<_i32.PageRouteInfo>? children})
      : super(
          CommunityRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommunityRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i6.CommunityPage();
    },
  );
}

/// generated route for
/// [_i7.DietPrefScreen]
class DietPrefRoute extends _i32.PageRouteInfo<DietPrefRouteArgs> {
  DietPrefRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          DietPrefRoute.name,
          args: DietPrefRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'DietPrefRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DietPrefRouteArgs>();
      return _i7.DietPrefScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class DietPrefRouteArgs {
  const DietPrefRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'DietPrefRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i8.EditProfileScreen]
class EditProfileRoute extends _i32.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i33.Key? key,
    required String currentFirstName,
    required String currentLastName,
    String? currentPhotoUrl,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            currentFirstName: currentFirstName,
            currentLastName: currentLastName,
            currentPhotoUrl: currentPhotoUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i8.EditProfileScreen(
        key: args.key,
        currentFirstName: args.currentFirstName,
        currentLastName: args.currentLastName,
        currentPhotoUrl: args.currentPhotoUrl,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.currentFirstName,
    required this.currentLastName,
    this.currentPhotoUrl,
  });

  final _i33.Key? key;

  final String currentFirstName;

  final String currentLastName;

  final String? currentPhotoUrl;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, currentFirstName: $currentFirstName, currentLastName: $currentLastName, currentPhotoUrl: $currentPhotoUrl}';
  }
}

/// generated route for
/// [_i9.ExercisePrefScreen]
class ExercisePrefRoute extends _i32.PageRouteInfo<ExercisePrefRouteArgs> {
  ExercisePrefRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          ExercisePrefRoute.name,
          args: ExercisePrefRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ExercisePrefRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisePrefRouteArgs>();
      return _i9.ExercisePrefScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class ExercisePrefRouteArgs {
  const ExercisePrefRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'ExercisePrefRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i10.ExperienceScreen]
class ExperienceRoute extends _i32.PageRouteInfo<ExperienceRouteArgs> {
  ExperienceRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          ExperienceRoute.name,
          args: ExperienceRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ExperienceRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExperienceRouteArgs>();
      return _i10.ExperienceScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class ExperienceRouteArgs {
  const ExperienceRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'ExperienceRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i11.FitnessLevelScreen]
class FitnessLevelRoute extends _i32.PageRouteInfo<FitnessLevelRouteArgs> {
  FitnessLevelRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          FitnessLevelRoute.name,
          args: FitnessLevelRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'FitnessLevelRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FitnessLevelRouteArgs>();
      return _i11.FitnessLevelScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class FitnessLevelRouteArgs {
  const FitnessLevelRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'FitnessLevelRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i12.GenderScreen]
class GenderRoute extends _i32.PageRouteInfo<GenderRouteArgs> {
  GenderRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          GenderRoute.name,
          args: GenderRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'GenderRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GenderRouteArgs>();
      return _i12.GenderScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class GenderRouteArgs {
  const GenderRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'GenderRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i13.GetStartedScreen]
class GetStartedRoute extends _i32.PageRouteInfo<void> {
  const GetStartedRoute({List<_i32.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i13.GetStartedScreen();
    },
  );
}

/// generated route for
/// [_i14.GoalScreen]
class GoalRoute extends _i32.PageRouteInfo<void> {
  const GoalRoute({List<_i32.PageRouteInfo>? children})
      : super(
          GoalRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoalRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i14.GoalScreen();
    },
  );
}

/// generated route for
/// [_i15.HelpSupportScreen]
class HelpSupportRoute extends _i32.PageRouteInfo<void> {
  const HelpSupportRoute({List<_i32.PageRouteInfo>? children})
      : super(
          HelpSupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpSupportRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i15.HelpSupportScreen();
    },
  );
}

/// generated route for
/// [_i16.LoginScreen]
class LoginRoute extends _i32.PageRouteInfo<void> {
  const LoginRoute({List<_i32.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i16.LoginScreen();
    },
  );
}

/// generated route for
/// [_i17.MainScreen]
class MainRoute extends _i32.PageRouteInfo<void> {
  const MainRoute({List<_i32.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i17.MainScreen();
    },
  );
}

/// generated route for
/// [_i18.MealsPage]
class MealsRoute extends _i32.PageRouteInfo<void> {
  const MealsRoute({List<_i32.PageRouteInfo>? children})
      : super(
          MealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MealsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i18.MealsPage();
    },
  );
}

/// generated route for
/// [_i19.OnboardingCompleteScreen]
class OnboardingCompleteRoute
    extends _i32.PageRouteInfo<OnboardingCompleteRouteArgs> {
  OnboardingCompleteRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel finalProfile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          OnboardingCompleteRoute.name,
          args: OnboardingCompleteRouteArgs(
            key: key,
            finalProfile: finalProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingCompleteRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingCompleteRouteArgs>();
      return _i19.OnboardingCompleteScreen(
        key: args.key,
        finalProfile: args.finalProfile,
      );
    },
  );
}

class OnboardingCompleteRouteArgs {
  const OnboardingCompleteRouteArgs({
    this.key,
    required this.finalProfile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel finalProfile;

  @override
  String toString() {
    return 'OnboardingCompleteRouteArgs{key: $key, finalProfile: $finalProfile}';
  }
}

/// generated route for
/// [_i20.PhysicalLimitationsScreen]
class PhysicalLimitationsRoute
    extends _i32.PageRouteInfo<PhysicalLimitationsRouteArgs> {
  PhysicalLimitationsRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          PhysicalLimitationsRoute.name,
          args: PhysicalLimitationsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'PhysicalLimitationsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhysicalLimitationsRouteArgs>();
      return _i20.PhysicalLimitationsScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class PhysicalLimitationsRouteArgs {
  const PhysicalLimitationsRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'PhysicalLimitationsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i21.RegisterScreen]
class RegisterRoute extends _i32.PageRouteInfo<void> {
  const RegisterRoute({List<_i32.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i21.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i22.SleepQualityScreen]
class SleepQualityRoute extends _i32.PageRouteInfo<SleepQualityRouteArgs> {
  SleepQualityRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          SleepQualityRoute.name,
          args: SleepQualityRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SleepQualityRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SleepQualityRouteArgs>();
      return _i22.SleepQualityScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class SleepQualityRouteArgs {
  const SleepQualityRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SleepQualityRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i23.SpecificSuppScreen]
class SpecificSuppRoute extends _i32.PageRouteInfo<SpecificSuppRouteArgs> {
  SpecificSuppRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          SpecificSuppRoute.name,
          args: SpecificSuppRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SpecificSuppRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpecificSuppRouteArgs>();
      return _i23.SpecificSuppScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class SpecificSuppRouteArgs {
  const SpecificSuppRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SpecificSuppRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i24.SplashScreen]
class SplashRoute extends _i32.PageRouteInfo<void> {
  const SplashRoute({List<_i32.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i24.SplashScreen();
    },
  );
}

/// generated route for
/// [_i25.SupplementsScreen]
class SupplementsRoute extends _i32.PageRouteInfo<SupplementsRouteArgs> {
  SupplementsRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          SupplementsRoute.name,
          args: SupplementsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplementsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SupplementsRouteArgs>();
      return _i25.SupplementsScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class SupplementsRouteArgs {
  const SupplementsRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SupplementsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i26.TipsTricksScreen]
class TipsTricksRoute extends _i32.PageRouteInfo<void> {
  const TipsTricksRoute({List<_i32.PageRouteInfo>? children})
      : super(
          TipsTricksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TipsTricksRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i26.TipsTricksScreen();
    },
  );
}

/// generated route for
/// [_i27.WeightScreen]
class WeightRoute extends _i32.PageRouteInfo<WeightRouteArgs> {
  WeightRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          WeightRoute.name,
          args: WeightRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WeightRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WeightRouteArgs>();
      return _i27.WeightScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class WeightRouteArgs {
  const WeightRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WeightRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i28.WorkoutDetailPage]
class WorkoutDetailRoute extends _i32.PageRouteInfo<WorkoutDetailRouteArgs> {
  WorkoutDetailRoute({
    _i33.Key? key,
    required _i35.WorkoutModel workout,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          WorkoutDetailRoute.name,
          args: WorkoutDetailRouteArgs(
            key: key,
            workout: workout,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutDetailRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutDetailRouteArgs>();
      return _i28.WorkoutDetailPage(
        key: args.key,
        workout: args.workout,
        profile: args.profile,
      );
    },
  );
}

class WorkoutDetailRouteArgs {
  const WorkoutDetailRouteArgs({
    this.key,
    required this.workout,
    required this.profile,
  });

  final _i33.Key? key;

  final _i35.WorkoutModel workout;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WorkoutDetailRouteArgs{key: $key, workout: $workout, profile: $profile}';
  }
}

/// generated route for
/// [_i29.WorkoutSchedulePage]
class WorkoutScheduleRoute
    extends _i32.PageRouteInfo<WorkoutScheduleRouteArgs> {
  WorkoutScheduleRoute({
    _i33.Key? key,
    required List<_i35.WorkoutModel> workouts,
    required dynamic profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          WorkoutScheduleRoute.name,
          args: WorkoutScheduleRouteArgs(
            key: key,
            workouts: workouts,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutScheduleRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutScheduleRouteArgs>();
      return _i29.WorkoutSchedulePage(
        key: args.key,
        workouts: args.workouts,
        profile: args.profile,
      );
    },
  );
}

class WorkoutScheduleRouteArgs {
  const WorkoutScheduleRouteArgs({
    this.key,
    required this.workouts,
    required this.profile,
  });

  final _i33.Key? key;

  final List<_i35.WorkoutModel> workouts;

  final dynamic profile;

  @override
  String toString() {
    return 'WorkoutScheduleRouteArgs{key: $key, workouts: $workouts, profile: $profile}';
  }
}

/// generated route for
/// [_i30.WorkoutsPage]
class WorkoutsRoute extends _i32.PageRouteInfo<void> {
  const WorkoutsRoute({List<_i32.PageRouteInfo>? children})
      : super(
          WorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutsRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      return const _i30.WorkoutsPage();
    },
  );
}

/// generated route for
/// [_i31.WorkoutsPerWeekScreen]
class WorkoutsPerWeekRoute
    extends _i32.PageRouteInfo<WorkoutsPerWeekRouteArgs> {
  WorkoutsPerWeekRoute({
    _i33.Key? key,
    required _i34.FitnessProfileModel profile,
    List<_i32.PageRouteInfo>? children,
  }) : super(
          WorkoutsPerWeekRoute.name,
          args: WorkoutsPerWeekRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutsPerWeekRoute';

  static _i32.PageInfo page = _i32.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutsPerWeekRouteArgs>();
      return _i31.WorkoutsPerWeekScreen(
        key: args.key,
        profile: args.profile,
      );
    },
  );
}

class WorkoutsPerWeekRouteArgs {
  const WorkoutsPerWeekRouteArgs({
    this.key,
    required this.profile,
  });

  final _i33.Key? key;

  final _i34.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WorkoutsPerWeekRouteArgs{key: $key, profile: $profile}';
  }
}
