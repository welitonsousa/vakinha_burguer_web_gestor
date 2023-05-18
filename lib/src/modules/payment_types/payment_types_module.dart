import 'package:dw10/src/repositories/payment/payment_repository.dart';
import 'package:dw10/src/repositories/payment/payment_repository_impl.dart';
import 'package:dw10/src/services/payment/payment_service.dart';
import 'package:dw10/src/services/payment/payment_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './payment_types_controller.dart';
import './payment_types_page.dart';

class PaymentTypesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<PaymentRepository>(
        (i) => PaymentRepositoryImpl(restClient: i())),
    Bind.lazySingleton<PaymentService>(
        (i) => PaymentServiceImpl(repository: i())),
    Bind.lazySingleton((i) => PaymentTypesController(service: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PaymentTypesPage()),
  ];
}
