import 'package:joyla/data/local/storage_repository.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/user/user_model.dart';
import 'package:joyla/data/models/websites/website_model.dart';
import 'package:joyla/data/network/api_service.dart';

class WebsiteRepository {
  final ApiService apiService;

  WebsiteRepository({required this.apiService});

  Future<UniversalData> getWebsites() async => apiService.getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      apiService.getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel newWebsite) async =>
      apiService.createWebsite(websiteModel: newWebsite);
}
