import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/data/models/user/user_model.dart';
import 'package:joyla/presentation/app_routes.dart';
import 'package:joyla/presentation/auth/widgets/gender_selector.dart';
import 'package:joyla/presentation/auth/widgets/global_button.dart';
import 'package:joyla/presentation/auth/widgets/global_text_fields.dart';
import 'package:joyla/utils/colors/app_colors.dart';
import 'package:joyla/utils/ui_utils/error_message_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ImagePicker picker = ImagePicker();

  XFile? file;

  int gender = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up Page"),),
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            GlobalTextField(
              hintText: "Username",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: usernameController,
            ),
            GlobalTextField(
              hintText: "Contact",
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: phoneController,
            ),
            GlobalTextField(
              hintText: "Gmail",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: gmailController,
            ),
            GlobalTextField(
              hintText: "Profession",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: professionController,
            ),
            GlobalTextField(
              hintText: "Password",
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            GenderSelector(
              onMaleTap: () {
                setState(() {
                  gender = 1;
                });
              },
              onFemaleTap: () {
                setState(() {
                  gender = 0;
                });
              },
              gender: gender,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
              },
              child: const Text(
                "Ligin",
                style: TextStyle(
                    color: Color(0xFF4F8962),
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 20),
            GlobalButton(
                title: "Register",
                onTap: () {
                  if (file != null &&
                      usernameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      gmailController.text.isNotEmpty &&
                      professionController.text.isNotEmpty &&
                      passwordController.text.length > 5) {
                    context.read<AuthCubit>().sendCodeToGmail(
                          gmailController.text,
                          passwordController.text,
                        );
                  }
                }),
            TextButton(
                onPressed: () {
                  showBottomSheetDialog();
                },
                child: Text("Select image"))
          ],
        );
      }, listener: (context, state) {
        if (state is AuthSendCodeSuccessState) {
          UserModel userModel = UserModel(
            password: passwordController.text,
            username: usernameController.text,
            email: gmailController.text,
            avatar: file!.path,
            contact: phoneController.text,
            gender: gender.toString(),
            profession: professionController.text,
            role: "male",
          );
          Navigator.pushNamed(
            context,
            RouteNames.confirmGmail,
            arguments: userModel,
          );
        }

        if (state is AuthErrorState) {
          showErrorMessage(message: state.errorText, context: context);
        }
      }),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null) {
      file = xFile;
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      file = xFile;
    }
  }
}
