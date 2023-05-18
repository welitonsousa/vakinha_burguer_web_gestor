import 'package:dw10/src/modules/products/product_detail/product_detail_module.dart';
import 'package:dw10/src/repositories/products/products_repository.dart';
import 'package:dw10/src/repositories/products/products_repository_impl.dart';
import 'package:dw10/src/services/products/products_service.dart';
import 'package:dw10/src/services/products/products_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import './products_controller.dart';
import './products_page.dart';

class ProductsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ProductsRepository>((i) => ProductsRepositoryImpl(i())),
    Bind.lazySingleton<ProductService>((i) => ProductServiceImpl(i())),
    Bind.lazySingleton((i) => ProductsController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ProductsPage()),
    ModuleRoute('/save/', module: ProductDetailModule()),
  ];
}
