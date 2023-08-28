import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/websites/website_model.dart';
import 'package:joyla/data/network/open_api_service.dart';
import 'package:joyla/data/network/secure_api_service.dart';

class WebsiteRepository {
  final SecureApiService secureApiService;
  final OpenApiService openApiService;

  WebsiteRepository({
    required this.secureApiService,
    required this.openApiService,
  });

  Future<UniversalData> getWebsites() async => openApiService.getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      openApiService.getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel newWebsite) async =>
      secureApiService.createWebsite(websiteModel: newWebsite);
}
