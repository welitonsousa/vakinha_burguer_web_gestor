import 'package:dw10/src/core/rest_client/dio_client.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/core/storage/session_storage.dart';
import 'package:dw10/src/core/storage/storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<Storage>((i) => SessionStorage(), export: true),
        Bind.lazySingleton<RestClient>((i) => DioClient(i()), export: true)
      ];
}
