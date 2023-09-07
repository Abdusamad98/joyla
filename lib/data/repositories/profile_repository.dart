import 'package:network_side/models/universal_data.dart';
import 'package:network_side/network/secure_api_service.dart';


class ProfileRepository {
  final SecureApiService apiService;

  ProfileRepository({required this.apiService});

  Future<UniversalData> getUserData() async => apiService.getProfileData();
}
