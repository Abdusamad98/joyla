import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joyla/cubits/website_add/website_add_cubit.dart';
import 'package:joyla/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:joyla/data/models/status/form_status.dart';
import 'package:joyla/data/models/websites/website_field_keys.dart';
import 'package:joyla/presentation/auth/widgets/global_button.dart';
import 'package:joyla/presentation/auth/widgets/global_text_fields.dart';
import 'package:joyla/utils/colors/app_colors.dart';
import 'package:joyla/utils/constants/constants.dart';
import 'package:joyla/utils/ui_utils/error_message_dialog.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Website "),
      ),
      body: BlocConsumer<WebsiteAddCubit, WebsiteAddState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Add Website",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              GlobalTextField(
                hintText: "LINK",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.link,
                        value: v,
                      );
                },
              ),
              GlobalTextField(
                hintText: "NAME",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.name,
                        value: v,
                      );
                },
              ),
              GlobalTextField(
                hintText: "AUTHOR",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.author,
                        value: v,
                      );
                },
              ),
              GlobalTextField(
                hintText: "CONTACT",
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.contact,
                        value: v,
                      );
                },
              ),
              GlobalTextField(
                hintText: "HASHTAG",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  context.read<WebsiteAddCubit>().updateWebsiteField(
                        fieldKey: WebsiteFieldKeys.hashtag,
                        value: "#$v",
                      );
                },
              ),
              TextButton(
                onPressed: () {
                  showBottomSheetDialog();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Select Image"), Icon(Icons.image)],
                ),
              ),
              const SizedBox(height: 20),
              GlobalButton(
                title: "Add Website",
                onTap: () {
                  if (context.read<WebsiteAddCubit>().state.canAddWebsite()) {
                    context.read<WebsiteAddCubit>().createWebsite(context);
                  } else {
                    showErrorMessage(
                        message: "Ma'lumotlar to'liq emas!!!",
                        context: context);
                  }
                },
              )
            ],
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }

          if (state.status == FormStatus.success &&
              state.statusText == StatusTextConstants.websiteAdd) {
            BlocProvider.of<WebsiteFetchCubit>(context).getWebsites(context);
            Navigator.pop(context);
          }
        },
      ),
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

    if (xFile != null && context.mounted) {
      BlocProvider.of<WebsiteAddCubit>(context).updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      BlocProvider.of<WebsiteAddCubit>(context).updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}
