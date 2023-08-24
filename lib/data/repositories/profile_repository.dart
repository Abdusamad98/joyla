import 'package:joyla/data/local/storage_repository.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/models/user/user_model.dart';
import 'package:joyla/data/network/api_service.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  Future<UniversalData> getUserData() async => apiService.getProfileData();
}
