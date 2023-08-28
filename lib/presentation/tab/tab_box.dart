import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/blocs/articles/article_bloc.dart';
import 'package:joyla/blocs/articles/article_event.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/cubits/profile/profile_cubit.dart';
import 'package:joyla/cubits/tab/tab_cubit.dart';
import 'package:joyla/presentation/app_routes.dart';
import 'package:joyla/presentation/tab/articles/articles_screen.dart';
import 'package:joyla/presentation/tab/websites/websites_screen.dart';
import 'package:joyla/presentation/tab/profile/profile_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getUserData();
    BlocProvider.of<ArticleBloc>(context).add(GetArticles());
    screens = [
      const ArticlesScreen(),
      const WebsitesScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        child: IndexedStack(
          index: context.watch<TabCubit>().state,
          children: screens,
        ),
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Websites"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Articles"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTabIndex,
      ),
    );
  }
}
