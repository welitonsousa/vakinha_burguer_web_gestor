import 'package:dw10/src/modules/sign/sign_controller.dart';
import 'package:dw10/src/repositories/auth/auth_repository.dart';
import 'package:dw10/src/repositories/auth/auth_repository_imp.dart';
import 'package:dw10/src/services/auth/auth_service.dart';
import 'package:dw10/src/services/auth/auth_service_imp.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './sign_page.dart';

class SignModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<AuthRepository>((i) => AuthRepositoryImp(i())),
    Bind.lazySingleton<AuthService>((i) => AuthServiceImp(i(), i())),
    Bind.lazySingleton((i) => SignController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const SignPage()),
  ];
}
