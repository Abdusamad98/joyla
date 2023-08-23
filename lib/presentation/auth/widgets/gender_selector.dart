import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/cubits/user_data/user_data_cubit.dart';
import 'package:joyla/data/models/user/user_field_keys.dart';
import 'package:joyla/utils/colors/app_colors.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    String gender =   context.watch<UserDataCubit>().state.userModel.gender;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor:
              gender == "male" ? AppColors.c_3669C9 : AppColors.white),
          onPressed: () {
            context.read<UserDataCubit>().updateCurrentUserField(
                  fieldKey: UserFieldKeys.gender,
                  value: "male",
                );
          },
          child: Text(
            "MALE",
            style: TextStyle(
                color: gender == "male" ? AppColors.white : AppColors.black),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    gender == "female" ? AppColors.c_3669C9 : AppColors.white),
            onPressed: () {
              context.read<UserDataCubit>().updateCurrentUserField(
                    fieldKey: UserFieldKeys.gender,
                    value: "female",
                  );
            },
            child: Text(
              "FEMALE",
              style: TextStyle(
                  color:
                  gender == "female" ? AppColors.white : AppColors.black),
            )),
      ],
    );
  }
}
