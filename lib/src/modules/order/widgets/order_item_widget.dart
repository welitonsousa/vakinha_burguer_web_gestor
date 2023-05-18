import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  const OrderItemWidget({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap?.call,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            const Text('Pedido: '),
            Text(
              '${order.id}',
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Expanded(child: SizedBox()),
            Text(
              order.status.name,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: order.status.color,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
