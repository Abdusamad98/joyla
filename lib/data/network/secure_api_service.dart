import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:joyla/data/local/storage_repository.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/user/user_model.dart';
import 'package:joyla/data/models/websites/website_model.dart';
import 'package:joyla/utils/constants/constants.dart';
import 'package:joyla/utils/utililty_functions/utility_functions.dart';

class SecureApiService {
  // DIO SETTINGS

  final _dioSecure = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  SecureApiService() {
    _init();
  }

  _init() {
    _dioSecure.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          requestOptions.headers
              .addAll({"token": StorageRepository.getString("token")});
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }



// - --------------- PROFILE -----------------

  Future<UniversalData> getProfileData() async {
    Response response;
    try {
      response = await _dioSecure.get('/users');

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: UserModel.fromJson(response.data["data"]));
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  // -------------- WEBSITES ------------------------

  Future<UniversalData> createWebsite(
      {required WebsiteModel websiteModel}) async {
    Response response;
    _dioSecure.options.headers = {
      "Accept": "multipart/form-data",
    };
    try {
      response = await _dioSecure.post(
        '/sites',
        data: await websiteModel.getFormData(),
      );
      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data["data"]);
      }
      return UniversalData(error: "Other Error");
    } on SocketException catch (e) {
      return UniversalData(error: e.toString());
    } on DioException catch (e) {
      return getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

}


