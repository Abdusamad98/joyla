import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:joyla/data/models/status/form_status.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/websites/website_field_keys.dart';
import 'package:joyla/data/models/websites/website_model.dart';
import 'package:joyla/data/repositories/website_repository.dart';
import 'package:joyla/utils/ui_utils/loading_dialog.dart';

part 'website_state.dart';

class WebsiteCubit extends Cubit<WebsiteState> {
  WebsiteCubit({required this.websiteRepository})
      : super(
          WebsiteState(
            websiteModel: WebsiteModel(
              name: "",
              image: "",
              author: "",
              hashtag: "",
              contact: "",
              likes: "",
              link: "",
            ),
            websites: const [],
          ),
        );

  final WebsiteRepository websiteRepository;

  createWebsite() async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    UniversalData response =
        await websiteRepository.createWebsite(state.websiteModel);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "website_added",
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  getWebsites(BuildContext context) async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    showLoading(context: context);
    UniversalData response = await websiteRepository.getWebsites();
   if(context.mounted) hideLoading(context: context);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_website",
          websites: response.data as List<WebsiteModel>,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  getWebsiteById(int websiteId) async {
    emit(state.copyWith(
      status: FormStatus.loading,
      statusText: "",
    ));
    UniversalData response = await websiteRepository.getWebsiteById(websiteId);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_website_by_id",
          websiteDetail: response.data as WebsiteModel,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  updateWebsiteField({
    required WebsiteFieldKeys fieldKey,
    required dynamic value,
  }) {
    WebsiteModel currentWebsite = state.websiteModel;

    switch (fieldKey) {
      case WebsiteFieldKeys.hashtag:
        {
          currentWebsite = currentWebsite.copyWith(hashtag: value as String);
          break;
        }
      case WebsiteFieldKeys.contact:
        {
          currentWebsite = currentWebsite.copyWith(contact: value as String);
          break;
        }
      case WebsiteFieldKeys.link:
        {
          currentWebsite = currentWebsite.copyWith(link: value as String);
          break;
        }
      case WebsiteFieldKeys.author:
        {
          currentWebsite = currentWebsite.copyWith(author: value as String);
          break;
        }
      case WebsiteFieldKeys.name:
        {
          currentWebsite = currentWebsite.copyWith(name: value as String);
          break;
        }
      case WebsiteFieldKeys.image:
        {
          currentWebsite = currentWebsite.copyWith(image: value as String);
          break;
        }
      case WebsiteFieldKeys.likes:
        {
          currentWebsite = currentWebsite.copyWith(likes: value as String);
          break;
        }
    }

    debugPrint("WEBSITE: ${currentWebsite.toString()}");

    emit(state.copyWith(websiteModel: currentWebsite));
  }
}
