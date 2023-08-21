import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyla/presentation/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 12),
        TextButton(
          onPressed: () {
            onChanged.call();
          },
          child: const Text(
            "Ligin",
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
    );
  }
}
