import 'package:flutter/material.dart';
import 'package:joyla/utils/colors/app_colors.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.onMaleTap,
    required this.onFemaleTap, required this.gender,
  });

  final VoidCallback onMaleTap;
  final VoidCallback onFemaleTap;
  final int gender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor:
                  gender == 1 ? AppColors.c_3669C9 : AppColors.white),
          onPressed: onMaleTap,
          child: Text(
            "MALE",
            style: TextStyle(
                color: gender == 1 ? AppColors.white : AppColors.black),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    gender == 0 ? AppColors.c_3669C9 : AppColors.white),
            onPressed: onFemaleTap,
            child: Text(
              "FEMALE",
              style: TextStyle(
                  color: gender == 0 ? AppColors.white : AppColors.black),
            )),
      ],
    );
  }
}
