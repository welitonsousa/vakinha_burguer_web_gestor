import 'package:dw10/src/core/helpers/formatters.dart';
import 'package:flutter/material.dart';

import 'package:dw10/src/models/product_model.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;
  final ValueChanged<ProductModel> clickEdit;

  const ProductItemWidget(
      {super.key, required this.product, required this.clickEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
            child: Image.network(
              "http://localhost:8080${product.image}",
              errorBuilder: (a, b, c) => Image.network(
                'https://blog.novasafra.com.br/wp-content/uploads/2022/04/Carnes-para-hamburguer-veja-as-6-melhores-que-voce-deve-experimentar.jpeg',
              ),
              fit: BoxFit.cover,
              // height: 150,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Tooltip(
              message: product.name,
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(Format.moneyDisplay(product.price)),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => clickEdit(product),
                icon: const Icon(Icons.edit),
              ),
            ],
          )
        ],
      ),
    );
  }
}
