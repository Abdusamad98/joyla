import 'package:network_side/models/universal_data.dart';
import 'package:network_side/network/secure_api_service.dart';
import 'package:network_side/network/open_api_service.dart';


class ArticleRepository {
  final SecureApiService secureApiService;
  final OpenApiService openApiService;

  ArticleRepository({
    required this.secureApiService,
    required this.openApiService,
  });

  Future<UniversalData> getArticles() async => openApiService.getArticles();

}
