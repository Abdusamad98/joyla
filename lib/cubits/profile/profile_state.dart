part of 'profile_cubit.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final UserModel userModel;

  ProfileSuccessState({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class ProfileErrorState extends ProfileState {
  final String errorText;

  ProfileErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}
