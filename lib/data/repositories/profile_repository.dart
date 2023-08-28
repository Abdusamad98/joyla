import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/network/secure_api_service.dart';

class ProfileRepository {
  final SecureApiService apiService;

  ProfileRepository({required this.apiService});

  Future<UniversalData> getUserData() async => apiService.getProfileData();
}
