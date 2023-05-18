import 'package:dw10/src/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> findById(int id);
}
