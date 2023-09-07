import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joyla/blocs/articles/article_bloc.dart';
import 'package:joyla/blocs/articles/article_event.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/cubits/profile/profile_cubit.dart';
import 'package:joyla/cubits/tab/tab_cubit.dart';
import 'package:joyla/cubits/user_data/user_data_cubit.dart';
import 'package:joyla/cubits/website_add/website_add_cubit.dart';
import 'package:joyla/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:network_side/local/storage_repository.dart';
import 'package:network_side/network/secure_api_service.dart';
import 'package:network_side/network/open_api_service.dart';
import 'package:joyla/data/repositories/article_repository.dart';
import 'package:joyla/data/repositories/auth_repository.dart';
import 'package:joyla/data/repositories/profile_repository.dart';
import 'package:joyla/data/repositories/website_repository.dart';
import 'package:joyla/presentation/app_routes.dart';
import 'package:joyla/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageRepository.getInstance();

  runApp(App(
    secureApiService: SecureApiService(),
    openApiService: OpenApiService(),
  ));
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.secureApiService,
    required this.openApiService,
  });

  final SecureApiService secureApiService;
  final OpenApiService openApiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            openApiService: openApiService,
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(apiService: secureApiService),
        ),
        RepositoryProvider(
          create: (context) => WebsiteRepository(
            secureApiService: secureApiService,
            openApiService: openApiService,
          ),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepository(
            secureApiService: secureApiService,
            openApiService: openApiService,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
              create: (context) => ArticleBloc(
                  articleRepository: context.read<ArticleRepository>())),
          BlocProvider(create: (context) => TabCubit()),
          BlocProvider(create: (context) => UserDataCubit()),
          BlocProvider(
              create: (context) => ProfileCubit(
                  profileRepository: context.read<ProfileRepository>())),
          BlocProvider(
            create: (context) => WebsiteAddCubit(
                websiteRepository: context.read<WebsiteRepository>()),
          ),
          BlocProvider(
            create: (context) => WebsiteFetchCubit(
                websiteRepository: context.read<WebsiteRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
