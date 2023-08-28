import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/websites/website_model.dart';
import 'package:joyla/data/network/open_api_service.dart';
import 'package:joyla/data/network/secure_api_service.dart';

class ArticleRepository {
  final SecureApiService secureApiService;
  final OpenApiService openApiService;

  ArticleRepository({
    required this.secureApiService,
    required this.openApiService,
  });

  Future<UniversalData> getArticles() async => openApiService.getArticles();

}
