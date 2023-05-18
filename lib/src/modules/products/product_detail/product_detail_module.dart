import 'package:flutter_modular/flutter_modular.dart';
import './product_detail_controller.dart';
import './product_detail_page.dart';

class ProductDetailModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProductDetailController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ProductDetailPage()),
  ];
}
