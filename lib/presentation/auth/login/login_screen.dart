
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/presentation/app_routes.dart';
import 'package:joyla/presentation/auth/widgets/global_button.dart';
import 'package:joyla/presentation/auth/widgets/global_text_fields.dart';
import 'package:joyla/utils/ui_utils/error_message_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String gmail = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login page"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if ((state is AuthLoadingState)||(state is AuthLoggedState)) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              const SizedBox(height: 24),
              GlobalTextField(
                hintText: "Gmail",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  gmail = v;
                },
              ),
              GlobalTextField(
                hintText: "Password",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  password = v;
                },
              ),
              GlobalButton(
                  title: ("Login"),
                  onTap: () {
                    if (gmail.isNotEmpty && password.isNotEmpty) {
                      context.read<AuthCubit>().loginUser(
                            gmail: gmail,
                            password: password,
                          );
                    }
                  }),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RouteNames.registerScreen);
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Color(0xFF4F8962),
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthLoggedState) {
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }
          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<AuthCubit>().updateState();
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
