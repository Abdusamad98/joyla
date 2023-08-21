import 'package:flutter/material.dart';
import 'package:joyla/presentation/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              onChanged.call();
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                  color: Color(0xFF4F8962),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          TextButton(
            onPressed: () {
             Navigator.pushNamed(context, RouteNames.confirmGmail);
            },
            child: const Text(
              "First Confirm your",
              style: TextStyle(
                  color: Color(0xFF4F8962),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
