import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/cubits/auth/auth_cubit.dart';
import 'package:joyla/cubits/website/website_cubit.dart';
import 'package:joyla/data/models/status/form_status.dart';
import 'package:joyla/data/models/websites/website_model.dart';
import 'package:joyla/data/repositories/auth_repository.dart';
import 'package:joyla/presentation/app_routes.dart';
import 'package:joyla/utils/ui_utils/error_message_dialog.dart';
import 'package:joyla/utils/ui_utils/loading_dialog.dart';

class WebsitesScreen extends StatefulWidget {
  const WebsitesScreen({super.key});

  @override
  State<WebsitesScreen> createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    Future.microtask(
        () => BlocProvider.of<WebsiteCubit>(context).getWebsites(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addWebsite);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocConsumer<WebsiteCubit, WebsiteState>(
        builder: (context, state) {
          return ListView(
            children: [
              ...List.generate(state.websites.length, (index) {
                WebsiteModel website = state.websites[index];
                return ListTile(
                  title: Text(
                    website.name,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(website.link),
                );
              })
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
          if (state.statusText == "website_added") {
            BlocProvider.of<WebsiteCubit>(context).getWebsites(context);
          }
        },
      ),
    );
  }
}
