import 'dart:async';

import 'package:dw10/src/core/storage/storage.dart';
import 'package:dw10/src/core/ui/layout/main_layout.dart';
import 'package:dw10/src/modules/core/core_module.dart';
import 'package:dw10/src/modules/home/home_page.dart';
import 'package:dw10/src/modules/order/order_module.dart';
import 'package:dw10/src/modules/payment_types/payment_types_module.dart';
import 'package:dw10/src/modules/products/products_module.dart';
import 'package:dw10/src/modules/sign/sign_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/sign/', module: SignModule()),
        ChildRoute('/',
            transition: TransitionType.noTransition,
            child: (context, args) => const MainLayout(child: RouterOutlet()),
            guards: [
              AuthGuard()
            ],
            children: [
              ChildRoute('/home/', child: (context, args) => const HomePage()),
              ModuleRoute('/payment-type/', module: PaymentTypesModule()),
              ModuleRoute('/products/', module: ProductsModule()),
              ModuleRoute('/order/', module: OrderModule()),
            ]),
      ];
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/sign');

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final storage = Modular.get<Storage>();
    return storage.getData(StorageKeys.ACCESS_TOKEN).isNotEmpty;
  }
}
