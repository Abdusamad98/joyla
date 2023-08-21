import 'package:bloc/bloc.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  final AuthRepository authRepository;

  Future<void> checkLoggedState() async {
    await Future.delayed(const Duration(seconds: 3));
    if (authRepository.getToken().isEmpty) {
      emit(AuthUnAuthenticatedState());
    } else {
      emit(AuthLoggedState());
    }
  }

  Future<void> sendCodeToGmail(String gmail, String password) async {
    emit(AuthLoadingState());
    UniversalData universalData = await authRepository.sendCodeToGmail(
      gmail: gmail,
      password: password,
    );
    if (universalData.error.isEmpty) {
      emit(AuthSendCodeSuccessState());
    } else {
      emit(AuthErrorState(errorText: universalData.error));
    }
  }
}
