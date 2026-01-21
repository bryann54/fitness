// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i35;
import 'package:fitness/features/account/presentation/pages/account_screen.dart'
    as _i1;
import 'package:fitness/features/account/presentation/pages/edit_profile_screen.dart'
    as _i8;
import 'package:fitness/features/account/presentation/pages/help_support_screen.dart'
    as _i16;
import 'package:fitness/features/account/presentation/pages/tips_tricks_screen.dart'
    as _i29;
import 'package:fitness/features/auth/presentation/pages/get_started_screen.dart'
    as _i14;
import 'package:fitness/features/auth/presentation/pages/login_screen.dart'
    as _i17;
import 'package:fitness/features/auth/presentation/pages/register_screen.dart'
    as _i24;
import 'package:fitness/features/auth/presentation/pages/splash_screen.dart'
    as _i27;
import 'package:fitness/features/community/presentation/pages/community_home_page.dart'
    as _i6;
import 'package:fitness/features/favourites/presentation/pages/favourites_screen.dart'
    as _i11;
import 'package:fitness/features/meals/data/models/meal_model.dart' as _i39;
import 'package:fitness/features/meals/presentation/pages/meal_detail_page.dart'
    as _i19;
import 'package:fitness/features/meals/presentation/pages/meals_page.dart'
    as _i20;
import 'package:fitness/features/notifications/presentation/pages/notifications_screen.dart'
    as _i21;
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart'
    as _i37;
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
    as _i12;
import 'package:fitness/features/onboarding/presentation/pages/gender_screen.dart'
    as _i13;
import 'package:fitness/features/onboarding/presentation/pages/goal_screen.dart'
    as _i15;
import 'package:fitness/features/onboarding/presentation/pages/onboarding_complete_screen.dart'
    as _i22;
import 'package:fitness/features/onboarding/presentation/pages/physical_limitations_screen.dart'
    as _i23;
import 'package:fitness/features/onboarding/presentation/pages/sleep_quality_screen.dart'
    as _i25;
import 'package:fitness/features/onboarding/presentation/pages/specific_supp_screen.dart'
    as _i26;
import 'package:fitness/features/onboarding/presentation/pages/supliments_screen.dart'
    as _i28;
import 'package:fitness/features/onboarding/presentation/pages/weight_screen.dart'
    as _i30;
import 'package:fitness/features/onboarding/presentation/pages/workouts_per_week_screen.dart'
    as _i34;
import 'package:fitness/features/workouts/data/models/workout_model.dart'
    as _i38;
import 'package:fitness/features/workouts/presentation/pages/all_exercises_page.dart'
    as _i3;
import 'package:fitness/features/workouts/presentation/pages/workout_detail_page.dart'
    as _i31;
import 'package:fitness/features/workouts/presentation/pages/workout_schedule_page.dart'
    as _i32;
import 'package:fitness/features/workouts/presentation/pages/workouts_page.dart'
    as _i33;
import 'package:fitness/main_screen.dart' as _i18;
import 'package:flutter/material.dart' as _i36;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i35.PageRouteInfo<void> {
  const AccountRoute({List<_i35.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountScreen();
    },
  );
}

/// generated route for
/// [_i2.AgeScreen]
class AgeRoute extends _i35.PageRouteInfo<AgeRouteArgs> {
  AgeRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          AgeRoute.name,
          args: AgeRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'AgeRoute';

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'AgeRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i3.AllExercisesPage]
class AllExercisesRoute extends _i35.PageRouteInfo<AllExercisesRouteArgs> {
  AllExercisesRoute({
    _i36.Key? key,
    required List<_i38.WorkoutModel> workouts,
    required dynamic profile,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final List<_i38.WorkoutModel> workouts;

  final dynamic profile;

  @override
  String toString() {
    return 'AllExercisesRouteArgs{key: $key, workouts: $workouts, profile: $profile}';
  }
}

/// generated route for
/// [_i4.AllSupplementsScreen]
class AllSupplementsRoute extends _i35.PageRouteInfo<AllSupplementsRouteArgs> {
  AllSupplementsRoute({
    _i36.Key? key,
    required List<String> initialSelection,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          AllSupplementsRoute.name,
          args: AllSupplementsRouteArgs(
            key: key,
            initialSelection: initialSelection,
          ),
          initialChildren: children,
        );

  static const String name = 'AllSupplementsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final List<String> initialSelection;

  @override
  String toString() {
    return 'AllSupplementsRouteArgs{key: $key, initialSelection: $initialSelection}';
  }
}

/// generated route for
/// [_i5.CaloriesScreen]
class CaloriesRoute extends _i35.PageRouteInfo<CaloriesRouteArgs> {
  CaloriesRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          CaloriesRoute.name,
          args: CaloriesRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'CaloriesRoute';

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'CaloriesRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i6.CommunityHomePage]
class CommunityHomeRoute extends _i35.PageRouteInfo<void> {
  const CommunityHomeRoute({List<_i35.PageRouteInfo>? children})
      : super(
          CommunityHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommunityHomeRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i6.CommunityHomePage();
    },
  );
}

/// generated route for
/// [_i7.DietPrefScreen]
class DietPrefRoute extends _i35.PageRouteInfo<DietPrefRouteArgs> {
  DietPrefRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          DietPrefRoute.name,
          args: DietPrefRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'DietPrefRoute';

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'DietPrefRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i8.EditProfileScreen]
class EditProfileRoute extends _i35.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i36.Key? key,
    required String currentFirstName,
    required String currentLastName,
    String? currentPhotoUrl,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

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
class ExercisePrefRoute extends _i35.PageRouteInfo<ExercisePrefRouteArgs> {
  ExercisePrefRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          ExercisePrefRoute.name,
          args: ExercisePrefRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ExercisePrefRoute';

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'ExercisePrefRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i10.ExperienceScreen]
class ExperienceRoute extends _i35.PageRouteInfo<ExperienceRouteArgs> {
  ExperienceRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          ExperienceRoute.name,
          args: ExperienceRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ExperienceRoute';

  static _i35.PageInfo page = _i35.PageInfo(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'ExperienceRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i11.FavouritesPage]
class FavouritesRoute extends _i35.PageRouteInfo<void> {
  const FavouritesRoute({List<_i35.PageRouteInfo>? children})
      : super(
          FavouritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i11.FavouritesPage();
    },
  );
}

/// generated route for
/// [_i12.FitnessLevelScreen]
class FitnessLevelRoute extends _i35.PageRouteInfo<FitnessLevelRouteArgs> {
  FitnessLevelRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          FitnessLevelRoute.name,
          args: FitnessLevelRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'FitnessLevelRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FitnessLevelRouteArgs>();
      return _i12.FitnessLevelScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'FitnessLevelRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i13.GenderScreen]
class GenderRoute extends _i35.PageRouteInfo<GenderRouteArgs> {
  GenderRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          GenderRoute.name,
          args: GenderRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'GenderRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GenderRouteArgs>();
      return _i13.GenderScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'GenderRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i14.GetStartedScreen]
class GetStartedRoute extends _i35.PageRouteInfo<void> {
  const GetStartedRoute({List<_i35.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i14.GetStartedScreen();
    },
  );
}

/// generated route for
/// [_i15.GoalScreen]
class GoalRoute extends _i35.PageRouteInfo<void> {
  const GoalRoute({List<_i35.PageRouteInfo>? children})
      : super(
          GoalRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoalRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i15.GoalScreen();
    },
  );
}

/// generated route for
/// [_i16.HelpSupportScreen]
class HelpSupportRoute extends _i35.PageRouteInfo<void> {
  const HelpSupportRoute({List<_i35.PageRouteInfo>? children})
      : super(
          HelpSupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpSupportRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i16.HelpSupportScreen();
    },
  );
}

/// generated route for
/// [_i17.LoginScreen]
class LoginRoute extends _i35.PageRouteInfo<void> {
  const LoginRoute({List<_i35.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i17.LoginScreen();
    },
  );
}

/// generated route for
/// [_i18.MainScreen]
class MainRoute extends _i35.PageRouteInfo<void> {
  const MainRoute({List<_i35.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i18.MainScreen();
    },
  );
}

/// generated route for
/// [_i19.MealDetailPage]
class MealDetailRoute extends _i35.PageRouteInfo<MealDetailRouteArgs> {
  MealDetailRoute({
    _i36.Key? key,
    required _i39.MealModel meal,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          MealDetailRoute.name,
          args: MealDetailRouteArgs(
            key: key,
            meal: meal,
          ),
          initialChildren: children,
        );

  static const String name = 'MealDetailRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealDetailRouteArgs>();
      return _i19.MealDetailPage(
        key: args.key,
        meal: args.meal,
      );
    },
  );
}

class MealDetailRouteArgs {
  const MealDetailRouteArgs({
    this.key,
    required this.meal,
  });

  final _i36.Key? key;

  final _i39.MealModel meal;

  @override
  String toString() {
    return 'MealDetailRouteArgs{key: $key, meal: $meal}';
  }
}

/// generated route for
/// [_i20.MealsPage]
class MealsRoute extends _i35.PageRouteInfo<void> {
  const MealsRoute({List<_i35.PageRouteInfo>? children})
      : super(
          MealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MealsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i20.MealsPage();
    },
  );
}

/// generated route for
/// [_i21.NotificationsScreen]
class NotificationsRoute extends _i35.PageRouteInfo<void> {
  const NotificationsRoute({List<_i35.PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i21.NotificationsScreen();
    },
  );
}

/// generated route for
/// [_i22.OnboardingCompleteScreen]
class OnboardingCompleteRoute
    extends _i35.PageRouteInfo<OnboardingCompleteRouteArgs> {
  OnboardingCompleteRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel finalProfile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          OnboardingCompleteRoute.name,
          args: OnboardingCompleteRouteArgs(
            key: key,
            finalProfile: finalProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingCompleteRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingCompleteRouteArgs>();
      return _i22.OnboardingCompleteScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel finalProfile;

  @override
  String toString() {
    return 'OnboardingCompleteRouteArgs{key: $key, finalProfile: $finalProfile}';
  }
}

/// generated route for
/// [_i23.PhysicalLimitationsScreen]
class PhysicalLimitationsRoute
    extends _i35.PageRouteInfo<PhysicalLimitationsRouteArgs> {
  PhysicalLimitationsRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          PhysicalLimitationsRoute.name,
          args: PhysicalLimitationsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'PhysicalLimitationsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhysicalLimitationsRouteArgs>();
      return _i23.PhysicalLimitationsScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'PhysicalLimitationsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i24.RegisterScreen]
class RegisterRoute extends _i35.PageRouteInfo<void> {
  const RegisterRoute({List<_i35.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i24.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i25.SleepQualityScreen]
class SleepQualityRoute extends _i35.PageRouteInfo<SleepQualityRouteArgs> {
  SleepQualityRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          SleepQualityRoute.name,
          args: SleepQualityRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SleepQualityRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SleepQualityRouteArgs>();
      return _i25.SleepQualityScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SleepQualityRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i26.SpecificSuppScreen]
class SpecificSuppRoute extends _i35.PageRouteInfo<SpecificSuppRouteArgs> {
  SpecificSuppRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          SpecificSuppRoute.name,
          args: SpecificSuppRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SpecificSuppRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpecificSuppRouteArgs>();
      return _i26.SpecificSuppScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SpecificSuppRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i27.SplashScreen]
class SplashRoute extends _i35.PageRouteInfo<void> {
  const SplashRoute({List<_i35.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i27.SplashScreen();
    },
  );
}

/// generated route for
/// [_i28.SupplementsScreen]
class SupplementsRoute extends _i35.PageRouteInfo<SupplementsRouteArgs> {
  SupplementsRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          SupplementsRoute.name,
          args: SupplementsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplementsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SupplementsRouteArgs>();
      return _i28.SupplementsScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SupplementsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i29.TipsTricksScreen]
class TipsTricksRoute extends _i35.PageRouteInfo<void> {
  const TipsTricksRoute({List<_i35.PageRouteInfo>? children})
      : super(
          TipsTricksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TipsTricksRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i29.TipsTricksScreen();
    },
  );
}

/// generated route for
/// [_i30.WeightScreen]
class WeightRoute extends _i35.PageRouteInfo<WeightRouteArgs> {
  WeightRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          WeightRoute.name,
          args: WeightRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WeightRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WeightRouteArgs>();
      return _i30.WeightScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WeightRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i31.WorkoutDetailPage]
class WorkoutDetailRoute extends _i35.PageRouteInfo<WorkoutDetailRouteArgs> {
  WorkoutDetailRoute({
    _i36.Key? key,
    required _i38.WorkoutModel workout,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutDetailRouteArgs>();
      return _i31.WorkoutDetailPage(
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

  final _i36.Key? key;

  final _i38.WorkoutModel workout;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WorkoutDetailRouteArgs{key: $key, workout: $workout, profile: $profile}';
  }
}

/// generated route for
/// [_i32.WorkoutSchedulePage]
class WorkoutScheduleRoute
    extends _i35.PageRouteInfo<WorkoutScheduleRouteArgs> {
  WorkoutScheduleRoute({
    _i36.Key? key,
    required List<_i38.WorkoutModel> workouts,
    required dynamic profile,
    List<_i35.PageRouteInfo>? children,
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

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutScheduleRouteArgs>();
      return _i32.WorkoutSchedulePage(
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

  final _i36.Key? key;

  final List<_i38.WorkoutModel> workouts;

  final dynamic profile;

  @override
  String toString() {
    return 'WorkoutScheduleRouteArgs{key: $key, workouts: $workouts, profile: $profile}';
  }
}

/// generated route for
/// [_i33.WorkoutsPage]
class WorkoutsRoute extends _i35.PageRouteInfo<void> {
  const WorkoutsRoute({List<_i35.PageRouteInfo>? children})
      : super(
          WorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutsRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      return const _i33.WorkoutsPage();
    },
  );
}

/// generated route for
/// [_i34.WorkoutsPerWeekScreen]
class WorkoutsPerWeekRoute
    extends _i35.PageRouteInfo<WorkoutsPerWeekRouteArgs> {
  WorkoutsPerWeekRoute({
    _i36.Key? key,
    required _i37.FitnessProfileModel profile,
    List<_i35.PageRouteInfo>? children,
  }) : super(
          WorkoutsPerWeekRoute.name,
          args: WorkoutsPerWeekRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutsPerWeekRoute';

  static _i35.PageInfo page = _i35.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutsPerWeekRouteArgs>();
      return _i34.WorkoutsPerWeekScreen(
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

  final _i36.Key? key;

  final _i37.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WorkoutsPerWeekRouteArgs{key: $key, profile: $profile}';
  }
}
