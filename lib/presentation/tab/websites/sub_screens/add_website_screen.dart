import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joyla/cubits/website/website_cubit.dart';
import 'package:joyla/data/models/websites/website_field_keys.dart';
import 'package:joyla/utils/colors/app_colors.dart';
import 'package:joyla/utils/ui_utils/error_message_dialog.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {

  ImagePicker picker = ImagePicker();

  late WebsiteCubit bloc ;

  @override
  void initState() {
   bloc = BlocProvider.of<WebsiteCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Website "),
      ),
      body: ListView(
        children: [

          IconButton(
          onPressed: () {
            showBottomSheetDialog();
          },
          icon:const  Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              bloc.updateWebsiteField(
                fieldKey: WebsiteFieldKeys.link,
                value: "https://daryo.uz",
              );
              bloc.updateWebsiteField(
                fieldKey: WebsiteFieldKeys.name,
                value: "Daryo website",
              );
              bloc.updateWebsiteField(
                fieldKey: WebsiteFieldKeys.author,
                value: "Daryochilar",
              );
              bloc.updateWebsiteField(
                fieldKey: WebsiteFieldKeys.contact,
                value: "999090900",
              );
              bloc.updateWebsiteField(
                fieldKey: WebsiteFieldKeys.hashtag,
                value: "daryo, yangilik",
              );



              if (bloc.state.canAddWebsite()) {
                //showErrorMessage(message: "Yaroqli!!!", context: context);
                bloc.createWebsite();
              } else {
                showErrorMessage(
                    message: "Ma'lumotlar to'liq emas!!!", context: context);
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
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
      bloc.updateWebsiteField(
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
      bloc.updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}
