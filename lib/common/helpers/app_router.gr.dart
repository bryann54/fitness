// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:fitness/features/account/presentation/pages/account_screen.dart'
    as _i1;
import 'package:fitness/features/account/presentation/pages/edit_profile_screen.dart'
    as _i7;
import 'package:fitness/features/account/presentation/pages/help_support_screen.dart'
    as _i14;
import 'package:fitness/features/account/presentation/pages/tips_tricks_screen.dart'
    as _i25;
import 'package:fitness/features/auth/presentation/pages/get_started_screen.dart'
    as _i12;
import 'package:fitness/features/auth/presentation/pages/login_screen.dart'
    as _i15;
import 'package:fitness/features/auth/presentation/pages/register_screen.dart'
    as _i20;
import 'package:fitness/features/auth/presentation/pages/splash_screen.dart'
    as _i23;
import 'package:fitness/features/community/presentation/pages/community_page.dart'
    as _i5;
import 'package:fitness/features/meals/presentation/pages/meals_page.dart'
    as _i17;
import 'package:fitness/features/onboarding/data/models/fitness_profile_model.dart'
    as _i31;
import 'package:fitness/features/onboarding/presentation/pages/age_screen.dart'
    as _i2;
import 'package:fitness/features/onboarding/presentation/pages/all_suppliments_screen.dart'
    as _i3;
import 'package:fitness/features/onboarding/presentation/pages/calories_screen.dart'
    as _i4;
import 'package:fitness/features/onboarding/presentation/pages/diet_pref_screen.dart'
    as _i6;
import 'package:fitness/features/onboarding/presentation/pages/exercise_pref_screen.dart'
    as _i8;
import 'package:fitness/features/onboarding/presentation/pages/experience_screen.dart'
    as _i9;
import 'package:fitness/features/onboarding/presentation/pages/fitness_level_screen.dart'
    as _i10;
import 'package:fitness/features/onboarding/presentation/pages/gender_screen.dart'
    as _i11;
import 'package:fitness/features/onboarding/presentation/pages/goal_screen.dart'
    as _i13;
import 'package:fitness/features/onboarding/presentation/pages/onboarding_complete_screen.dart'
    as _i18;
import 'package:fitness/features/onboarding/presentation/pages/physical_limitations_screen.dart'
    as _i19;
import 'package:fitness/features/onboarding/presentation/pages/sleep_quality_screen.dart'
    as _i21;
import 'package:fitness/features/onboarding/presentation/pages/specific_supp_screen.dart'
    as _i22;
import 'package:fitness/features/onboarding/presentation/pages/supliments_screen.dart'
    as _i24;
import 'package:fitness/features/onboarding/presentation/pages/weight_screen.dart'
    as _i26;
import 'package:fitness/features/onboarding/presentation/pages/workouts_per_week_screen.dart'
    as _i28;
import 'package:fitness/features/workouts/presentation/pages/workouts_page.dart'
    as _i27;
import 'package:fitness/main_screen.dart' as _i16;
import 'package:flutter/material.dart' as _i30;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i29.PageRouteInfo<void> {
  const AccountRoute({List<_i29.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountScreen();
    },
  );
}

/// generated route for
/// [_i2.AgeScreen]
class AgeRoute extends _i29.PageRouteInfo<AgeRouteArgs> {
  AgeRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          AgeRoute.name,
          args: AgeRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'AgeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'AgeRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i3.AllSupplementsScreen]
class AllSupplementsRoute extends _i29.PageRouteInfo<AllSupplementsRouteArgs> {
  AllSupplementsRoute({
    _i30.Key? key,
    required List<String> initialSelection,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          AllSupplementsRoute.name,
          args: AllSupplementsRouteArgs(
            key: key,
            initialSelection: initialSelection,
          ),
          initialChildren: children,
        );

  static const String name = 'AllSupplementsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllSupplementsRouteArgs>();
      return _i3.AllSupplementsScreen(
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

  final _i30.Key? key;

  final List<String> initialSelection;

  @override
  String toString() {
    return 'AllSupplementsRouteArgs{key: $key, initialSelection: $initialSelection}';
  }
}

/// generated route for
/// [_i4.CaloriesScreen]
class CaloriesRoute extends _i29.PageRouteInfo<CaloriesRouteArgs> {
  CaloriesRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          CaloriesRoute.name,
          args: CaloriesRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'CaloriesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CaloriesRouteArgs>();
      return _i4.CaloriesScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'CaloriesRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i5.CommunityPage]
class CommunityRoute extends _i29.PageRouteInfo<void> {
  const CommunityRoute({List<_i29.PageRouteInfo>? children})
      : super(
          CommunityRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommunityRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.CommunityPage();
    },
  );
}

/// generated route for
/// [_i6.DietPrefScreen]
class DietPrefRoute extends _i29.PageRouteInfo<DietPrefRouteArgs> {
  DietPrefRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          DietPrefRoute.name,
          args: DietPrefRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'DietPrefRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DietPrefRouteArgs>();
      return _i6.DietPrefScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'DietPrefRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i7.EditProfileScreen]
class EditProfileRoute extends _i29.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i30.Key? key,
    required String currentFirstName,
    required String currentLastName,
    String? currentPhotoUrl,
    List<_i29.PageRouteInfo>? children,
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

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i7.EditProfileScreen(
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

  final _i30.Key? key;

  final String currentFirstName;

  final String currentLastName;

  final String? currentPhotoUrl;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, currentFirstName: $currentFirstName, currentLastName: $currentLastName, currentPhotoUrl: $currentPhotoUrl}';
  }
}

/// generated route for
/// [_i8.ExercisePrefScreen]
class ExercisePrefRoute extends _i29.PageRouteInfo<ExercisePrefRouteArgs> {
  ExercisePrefRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          ExercisePrefRoute.name,
          args: ExercisePrefRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ExercisePrefRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExercisePrefRouteArgs>();
      return _i8.ExercisePrefScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'ExercisePrefRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i9.ExperienceScreen]
class ExperienceRoute extends _i29.PageRouteInfo<ExperienceRouteArgs> {
  ExperienceRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          ExperienceRoute.name,
          args: ExperienceRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ExperienceRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExperienceRouteArgs>();
      return _i9.ExperienceScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'ExperienceRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i10.FitnessLevelScreen]
class FitnessLevelRoute extends _i29.PageRouteInfo<FitnessLevelRouteArgs> {
  FitnessLevelRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          FitnessLevelRoute.name,
          args: FitnessLevelRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'FitnessLevelRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FitnessLevelRouteArgs>();
      return _i10.FitnessLevelScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'FitnessLevelRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i11.GenderScreen]
class GenderRoute extends _i29.PageRouteInfo<GenderRouteArgs> {
  GenderRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          GenderRoute.name,
          args: GenderRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'GenderRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GenderRouteArgs>();
      return _i11.GenderScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'GenderRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i12.GetStartedScreen]
class GetStartedRoute extends _i29.PageRouteInfo<void> {
  const GetStartedRoute({List<_i29.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i12.GetStartedScreen();
    },
  );
}

/// generated route for
/// [_i13.GoalScreen]
class GoalRoute extends _i29.PageRouteInfo<void> {
  const GoalRoute({List<_i29.PageRouteInfo>? children})
      : super(
          GoalRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoalRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.GoalScreen();
    },
  );
}

/// generated route for
/// [_i14.HelpSupportScreen]
class HelpSupportRoute extends _i29.PageRouteInfo<void> {
  const HelpSupportRoute({List<_i29.PageRouteInfo>? children})
      : super(
          HelpSupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpSupportRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i14.HelpSupportScreen();
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i29.PageRouteInfo<void> {
  const LoginRoute({List<_i29.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginScreen();
    },
  );
}

/// generated route for
/// [_i16.MainScreen]
class MainRoute extends _i29.PageRouteInfo<void> {
  const MainRoute({List<_i29.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i16.MainScreen();
    },
  );
}

/// generated route for
/// [_i17.MealsPage]
class MealsRoute extends _i29.PageRouteInfo<void> {
  const MealsRoute({List<_i29.PageRouteInfo>? children})
      : super(
          MealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MealsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.MealsPage();
    },
  );
}

/// generated route for
/// [_i18.OnboardingCompleteScreen]
class OnboardingCompleteRoute
    extends _i29.PageRouteInfo<OnboardingCompleteRouteArgs> {
  OnboardingCompleteRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel finalProfile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          OnboardingCompleteRoute.name,
          args: OnboardingCompleteRouteArgs(
            key: key,
            finalProfile: finalProfile,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingCompleteRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingCompleteRouteArgs>();
      return _i18.OnboardingCompleteScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel finalProfile;

  @override
  String toString() {
    return 'OnboardingCompleteRouteArgs{key: $key, finalProfile: $finalProfile}';
  }
}

/// generated route for
/// [_i19.PhysicalLimitationsScreen]
class PhysicalLimitationsRoute
    extends _i29.PageRouteInfo<PhysicalLimitationsRouteArgs> {
  PhysicalLimitationsRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          PhysicalLimitationsRoute.name,
          args: PhysicalLimitationsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'PhysicalLimitationsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhysicalLimitationsRouteArgs>();
      return _i19.PhysicalLimitationsScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'PhysicalLimitationsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i20.RegisterScreen]
class RegisterRoute extends _i29.PageRouteInfo<void> {
  const RegisterRoute({List<_i29.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i20.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i21.SleepQualityScreen]
class SleepQualityRoute extends _i29.PageRouteInfo<SleepQualityRouteArgs> {
  SleepQualityRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          SleepQualityRoute.name,
          args: SleepQualityRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SleepQualityRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SleepQualityRouteArgs>();
      return _i21.SleepQualityScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SleepQualityRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i22.SpecificSuppScreen]
class SpecificSuppRoute extends _i29.PageRouteInfo<SpecificSuppRouteArgs> {
  SpecificSuppRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          SpecificSuppRoute.name,
          args: SpecificSuppRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SpecificSuppRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpecificSuppRouteArgs>();
      return _i22.SpecificSuppScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SpecificSuppRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i23.SplashScreen]
class SplashRoute extends _i29.PageRouteInfo<void> {
  const SplashRoute({List<_i29.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i23.SplashScreen();
    },
  );
}

/// generated route for
/// [_i24.SupplementsScreen]
class SupplementsRoute extends _i29.PageRouteInfo<SupplementsRouteArgs> {
  SupplementsRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          SupplementsRoute.name,
          args: SupplementsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplementsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SupplementsRouteArgs>();
      return _i24.SupplementsScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'SupplementsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i25.TipsTricksScreen]
class TipsTricksRoute extends _i29.PageRouteInfo<void> {
  const TipsTricksRoute({List<_i29.PageRouteInfo>? children})
      : super(
          TipsTricksRoute.name,
          initialChildren: children,
        );

  static const String name = 'TipsTricksRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i25.TipsTricksScreen();
    },
  );
}

/// generated route for
/// [_i26.WeightScreen]
class WeightRoute extends _i29.PageRouteInfo<WeightRouteArgs> {
  WeightRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          WeightRoute.name,
          args: WeightRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WeightRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WeightRouteArgs>();
      return _i26.WeightScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WeightRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i27.WorkoutsPage]
class WorkoutsRoute extends _i29.PageRouteInfo<void> {
  const WorkoutsRoute({List<_i29.PageRouteInfo>? children})
      : super(
          WorkoutsRoute.name,
          initialChildren: children,
        );

  static const String name = 'WorkoutsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i27.WorkoutsPage();
    },
  );
}

/// generated route for
/// [_i28.WorkoutsPerWeekScreen]
class WorkoutsPerWeekRoute
    extends _i29.PageRouteInfo<WorkoutsPerWeekRouteArgs> {
  WorkoutsPerWeekRoute({
    _i30.Key? key,
    required _i31.FitnessProfileModel profile,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          WorkoutsPerWeekRoute.name,
          args: WorkoutsPerWeekRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'WorkoutsPerWeekRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WorkoutsPerWeekRouteArgs>();
      return _i28.WorkoutsPerWeekScreen(
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

  final _i30.Key? key;

  final _i31.FitnessProfileModel profile;

  @override
  String toString() {
    return 'WorkoutsPerWeekRouteArgs{key: $key, profile: $profile}';
  }
}
