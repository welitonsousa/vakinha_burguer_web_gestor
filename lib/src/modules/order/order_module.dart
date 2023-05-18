import 'package:dw10/src/repositories/order/order_repository.dart';
import 'package:dw10/src/repositories/order/order_repository_impl.dart';
import 'package:dw10/src/repositories/payment/payment_repository.dart';
import 'package:dw10/src/repositories/payment/payment_repository_impl.dart';
import 'package:dw10/src/repositories/products/products_repository.dart';
import 'package:dw10/src/repositories/products/products_repository_impl.dart';
import 'package:dw10/src/repositories/user/user_repository.dart';
import 'package:dw10/src/repositories/user/user_repository_impl.dart';
import 'package:dw10/src/services/order/order_service.dart';
import 'package:dw10/src/services/order/order_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './order_controller.dart';
import './order_page.dart';

class OrderModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(i())),
    Bind.lazySingleton<PaymentRepository>(
      (i) => PaymentRepositoryImpl(
        restClient: i(),
      ),
    ),
    Bind.lazySingleton<OrderRepository>((i) => OrderRepositoryImpl(i())),
    Bind.lazySingleton<ProductsRepository>((i) => ProductsRepositoryImpl(i())),
    Bind.lazySingleton<OrderService>(
        (i) => OrderServiceImpl(i(), i(), i(), i())),
    Bind.lazySingleton((i) => OrderController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const OrderPage()),
  ];
}
