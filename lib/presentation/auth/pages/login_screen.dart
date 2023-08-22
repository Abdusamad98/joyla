import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/data/local/storage_repository.dart';
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
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
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
                controller: gmailController,
              ),
              GlobalTextField(
                hintText: "Password",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: passwordController,
              ),
              GlobalButton(
                  title: ("Login"),
                  onTap: () {
                    context.read<AuthCubit>().loginUser(
                          gmail: gmailController.text,
                          password: passwordController.text,
                        );
                  }),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RouteNames.registerScreen);
                },
                child: Text(
                  "Sign Up T:${StorageRepository.getString("token")}",
                  style: const TextStyle(
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
    );
  }
}