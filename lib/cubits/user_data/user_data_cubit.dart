import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:network_side/models/user/user_field_keys.dart';
import 'package:network_side/models/user/user_model.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit()
      : super(
          UserDataState(
            userModel: UserModel(
              password: "",
              username: "",
              email: "",
              avatar: '',
              contact: "",
              gender: "",
              profession: '',
              role: "",
            ),
            errorText: "",
          ),
        );

  updateCurrentUserField({
    required UserFieldKeys fieldKey,
    required dynamic value,
  }) {
    UserModel currentUser = state.userModel;

    switch (fieldKey) {
      case UserFieldKeys.username:
        {
          currentUser = currentUser.copyWith(username: value as String);
          break;
        }
      case UserFieldKeys.avatar:
        {
          currentUser = currentUser.copyWith(avatar: value as String);
          break;
        }
      case UserFieldKeys.gender:
        {
          currentUser = currentUser.copyWith(gender: value as String);
          break;
        }
      case UserFieldKeys.role:
        {
          currentUser = currentUser.copyWith(role: value as String);
          break;
        }
      case UserFieldKeys.profession:
        {
          currentUser = currentUser.copyWith(profession: value as String);
          break;
        }
      case UserFieldKeys.password:
        {
          currentUser = currentUser.copyWith(password: value as String);
          break;
        }
      case UserFieldKeys.contact:
        {
          currentUser = currentUser.copyWith(contact: value as String);
          break;
        }
      case UserFieldKeys.email:
        {
          currentUser = currentUser.copyWith(email: value as String);
          break;
        }
    }

    debugPrint("USER: ${currentUser.toString()}");

    emit(state.copyWith(userModel: currentUser));
  }

  bool canRegister() {
    UserModel currentUser = state.userModel;

    if (currentUser.contact.length < 9) {
      return false;
    }

    if (currentUser.username.isEmpty) {
      return false;
    }

    if (currentUser.avatar.isEmpty) {
      return false;
    }

    if (currentUser.email.isEmpty) {
      return false;
    }
    if (currentUser.password.isEmpty) {
      return false;
    }

    if (currentUser.profession.isEmpty) {
      return false;
    }

    if (currentUser.gender.isEmpty) {
      return false;
    }
    return true;
  }

  clearData() {
    emit(
      UserDataState(
        userModel: UserModel(
          password: "",
          username: "",
          email: "",
          avatar: '',
          contact: "",
          gender: "",
          profession: '',
          role: "",
        ),
        errorText: "",
      ),
    );
  }
}
