import 'package:auto_route/auto_route.dart';
import 'package:fitness/common/helpers/app_router.gr.dart';
import 'package:fitness/features/auth/presentation/bloc/auth_bloc.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthBloc authBloc;

  AuthGuard(this.authBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentUserState = authBloc.state;
    if (currentUserState is AuthAuthenticated) {
      resolver.next(true);
    } else if (currentUserState is AuthUnauthenticated) {
      router.replace(const LoginRoute());
    } else {
      router.replace(const LoginRoute());
    }
  }
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: GetStartedRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(
          page: MainRoute.page,
          guards: [AuthGuard(authBloc)],
          children: [
            AutoRoute(page: WorkoutsRoute.page),
            AutoRoute(page: MealsRoute.page),
            AutoRoute(page: CommunityRoute.page),
            AutoRoute(page: AccountRoute.page),
          ],
        ),
        AutoRoute(page: EditProfileRoute.page, guards: [AuthGuard(authBloc)]),
        AutoRoute(page: HelpSupportRoute.page, guards: [AuthGuard(authBloc)]),
        AutoRoute(page: TipsTricksRoute.page, guards: [AuthGuard(authBloc)]),
        AutoRoute(page: GoalRoute.page),
        AutoRoute(page: GenderRoute.page),
        AutoRoute(page: AgeRoute.page),
        AutoRoute(page: WeightRoute.page),
        // AutoRoute(page: HeightRoute.page),
        // AutoRoute(page: ActivityLevelRoute.page),
        AutoRoute(page: OnboardingCompleteRoute.page),
        AutoRoute(page: FitnessLevelRoute.page),
        AutoRoute(page: ExperienceRoute.page),
        AutoRoute(page: ExercisePrefRoute.page),
        AutoRoute(page: WorkoutsPerWeekRoute.page),
        AutoRoute(page: PhysicalLimitationsRoute.page),
        AutoRoute(page: DietPrefRoute.page),
        AutoRoute(page: SupplementsRoute.page),
        AutoRoute(page: SleepQualityRoute.page),
        AutoRoute(page: SpecificSuppRoute.page),
        AutoRoute(page: AllSupplementsRoute.page),
        AutoRoute(page: CaloriesRoute.page),
        AutoRoute(page: WorkoutsRoute.page),
        AutoRoute(page: WorkoutDetailRoute.page),
        AutoRoute(page: WorkoutScheduleRoute.page),
        AutoRoute(page: AllExercisesRoute.page),
      ];
}
