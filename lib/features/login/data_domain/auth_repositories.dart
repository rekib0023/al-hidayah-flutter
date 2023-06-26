import '../../../models/users.dart';
import 'auth_service.dart';

class AuthRepository {
  final AuthService _apiService = AuthService();

  Future<User> loginUser(String email, String password) async {
    try {
      return await _apiService.loginUser(email, password);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
