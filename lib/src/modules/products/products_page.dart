import 'dart:html';

import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/modules/products/products_controller.dart';
import 'package:dw10/src/modules/products/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = Modular.get<ProductsController>();
  final searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.findAllProducts();
      final q = Modular.args.queryParams['q'] ?? '';
      if (q.isNotEmpty) {
        searchController.text = q;
        controller.changeSearch(q);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                height: 40,
                child: TextFormField(
                  initialValue: controller.search,
                  decoration: const InputDecoration(
                    labelText: 'Pesquisar',
                  ),
                  onChanged: (v) {
                    final path = Modular.to.path.split('?').first;
                    window.history.pushState('', '', '#$path?q=$v');
                    controller.changeSearch(v);
                  },
                ),
              ),
              Text('Tipos de pagamentos', style: context.textTheme.titleLarge),
              OutlinedButton(
                child: const Text('Adicionar'),
                onPressed: () {
                  Modular.to.navigate('/products/save/');
                },
              ),
            ],
          ),
          Expanded(
            child: Observer(
              builder: (c) => GridView.builder(
                itemCount: controller.products.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (c, i) {
                  return ProductItemWidget(
                    product: controller.products[i],
                    clickEdit: (product) {
                      Modular.to.navigate('/products/save/?id=${product.id}');
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
