import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/user/user_model.dart';
import 'package:joyla/data/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());

  final ProfileRepository profileRepository;

  getUserData() async {
    emit(ProfileLoadingState());
    UniversalData response = await profileRepository.getUserData();
    if (response.error.isEmpty) {
      emit(ProfileSuccessState(userModel: response.data as UserModel));
    } else {
      emit(ProfileErrorState(errorText: response.error));
    }
  }
}
