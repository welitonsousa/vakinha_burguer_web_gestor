import 'package:dw10/src/models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> sign(String email, String password);
}
