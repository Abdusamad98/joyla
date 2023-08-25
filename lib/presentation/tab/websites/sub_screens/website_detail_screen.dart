import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/cubits/website_fetch/website_fetch_cubit.dart';
import 'package:joyla/data/models/status/form_status.dart';
import 'package:joyla/utils/constants/constants.dart';
import 'package:joyla/utils/ui_utils/error_message_dialog.dart';

class WebsiteDetailScreen extends StatelessWidget {
  const WebsiteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Website detail"),
      ),
      body: BlocConsumer<WebsiteFetchCubit, WebsiteFetchState>(
        builder: (context, state) {
          if (state.websiteDetail == null) {
            return const Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  baseUrl + state.websiteDetail!.image.substring(1),
                  width: 300,
                ),
                Text(
                  state.websiteDetail!.name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.contact,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.author,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.link,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  state.websiteDetail!.likes,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state.status == FormStatus.failure) {
            showErrorMessage(
              message: state.statusText,
              context: context,
            );
          }
        },
      ),
    );
  }
}
