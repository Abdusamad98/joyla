import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/cubits/tab/tab_cubit.dart';
import 'package:joyla/presentation/app_routes.dart';
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
    screens = [
      WebsitesScreen(),
      ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        child: screens[context.watch<TabCubit>().state],
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.web), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: context.watch<TabCubit>().state,
        onTap: context.read<TabCubit>().changeTabIndex,
      ),
    );
  }
}
