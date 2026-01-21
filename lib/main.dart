// main.dart - Fixed dependency injection order
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/common/res/colors.dart';
import 'package:fitness/features/community/presentation/bloc/buddies/buddies_bloc.dart';
import 'package:fitness/features/community/presentation/bloc/feed/feed_bloc.dart';
import 'package:fitness/features/community/presentation/bloc/groups/groups_bloc.dart';
import 'package:fitness/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:fitness/features/meals/presentation/bloc/meals_bloc.dart';
import 'package:fitness/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:fitness/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:fitness/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:fitness/common/helpers/app_router.dart';
import 'package:fitness/common/helpers/system_ui_helper.dart';
import 'package:fitness/common/notifiers/locale_provider.dart';
import 'package:fitness/common/widgets/global_bloc_observer.dart';
import 'package:fitness/core/di/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fitness/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitness/features/account/presentation/bloc/account_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemUIHelper.configureSystemUI();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kReleaseMode) {
    await dotenv.load(fileName: "env/.env");
  } else {
    Bloc.observer = AppGlobalBlocObserver();
    await dotenv.load(fileName: "env/.dev.env");
  }

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.initFlutter();

  await configureDependencies();

  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  final AuthBloc authBloc = getIt<AuthBloc>();
  final AccountBloc accountBloc = getIt<AccountBloc>();
  final WorkoutsBloc workoutsBloc = getIt<WorkoutsBloc>();
  final MealsBloc mealsBloc = getIt<MealsBloc>();
  final OnboardingBloc onboardingBloc = getIt<OnboardingBloc>();
  final FavouritesBloc favouritesBloc = getIt<FavouritesBloc>();
  final GroupsBloc groupsBloc = getIt<GroupsBloc>();
  final FeedBloc feedBloc = getIt<FeedBloc>();
  final BuddiesBloc buddiesBloc = getIt<BuddiesBloc>();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => localeProvider),
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
          lazy: false,
        ),
        BlocProvider<AccountBloc>(
          create: (context) => accountBloc,
        ),
        BlocProvider<WorkoutsBloc>(
          create: (context) => workoutsBloc,
        ),
        BlocProvider<OnboardingBloc>(
          create: (context) => onboardingBloc,
        ),
        BlocProvider<FavouritesBloc>(
          create: (context) => favouritesBloc,
        ),
        BlocProvider<MealsBloc>(
          create: (context) => mealsBloc,
        ),
        BlocProvider<GroupsBloc>(
          create: (context) => groupsBloc,
        ),
        BlocProvider<FeedBloc>(
          create: (context) => feedBloc,
        ),
        BlocProvider<BuddiesBloc>(
          create: (context) => buddiesBloc,
        ),
      ],
      child: MyApp(authBloc: authBloc),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  late final AppRouter _appRouter;

  MyApp({super.key, required this.authBloc}) {
    _appRouter = AppRouter(authBloc: authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: !kReleaseMode,
      routerConfig: _appRouter.config(),
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: _getSystemUiOverlayStyle(context),
          child: child!,
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.cardLight,
      cardColor: AppColors.cardLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cardLight,
        foregroundColor: AppColors.cardDark,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardLight,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[900],
      cardColor: Colors.grey[850],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: AppColors.cardLight,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[500],
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 24),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  SystemUiOverlayStyle _getSystemUiOverlayStyle(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isLight = brightness == Brightness.light;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          isLight ? AppColors.cardLight : Colors.grey[900],
      systemNavigationBarIconBrightness:
          isLight ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }
}
