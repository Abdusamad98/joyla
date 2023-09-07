
import 'package:network_side/models/websites/website_model.dart';
import 'package:network_side/network/secure_api_service.dart';
import 'package:network_side/network/open_api_service.dart';
import 'package:network_side/models/universal_data.dart';
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
