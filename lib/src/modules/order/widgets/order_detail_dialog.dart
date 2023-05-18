import 'package:dw10/src/core/helpers/formatters.dart';
import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/dtos/order_dto.dart';
import 'package:dw10/src/modules/order/order_controller.dart';
import 'package:dw10/src/modules/order/widgets/buttons_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class OrderDetailDialog extends StatefulWidget {
  final OrderDTO orderDetail;
  const OrderDetailDialog({super.key, required this.orderDetail});

  @override
  State<OrderDetailDialog> createState() => _OrderDetailDialogState();
}

class _OrderDetailDialogState extends State<OrderDetailDialog> {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer disposer;

  @override
  void initState() {
    disposer = reaction((p0) => controller.ordersStatusPage, (status) {
      if (status == OrderStatusPage.hideDialog) Modular.to.pop();
    });
    super.initState();
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  Text(
                    'Detalhes do pedido',
                    style: context.textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: Modular.to.pop,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text.rich(
                TextSpan(text: 'Nome do cliente: ', children: [
                  TextSpan(
                    text: widget.orderDetail.user.name,
                    style: context.textTheme.bodyLarge,
                  ),
                ]),
              ),
              const Divider(),
              ...widget.orderDetail.products
                  .map((e) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(e.name)),
                              Text((widget.orderDetail.order.products
                                      .singleWhere((o) => o.id == e.id))
                                  .amount
                                  .toString()),
                              Expanded(
                                  child: Text(
                                Format.moneyDisplay(e.price),
                                textAlign: TextAlign.end,
                              )),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: context.textTheme.bodyLarge),
                  Text(
                      Format.moneyDisplay(
                        widget.orderDetail.order.products
                            .fold(.0, (p, e) => p + (e.totalPrice * e.amount)),
                      ),
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(),
              Center(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(text: 'Endereço: ', children: [
                    TextSpan(
                      text: widget.orderDetail.order.address,
                      style: context.textTheme.bodyLarge,
                    ),
                  ]),
                ),
              ),
              const Divider(),
              Center(
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(text: 'Forma de pagamento: ', children: [
                    TextSpan(
                      text: widget.orderDetail.payment.name,
                      style: context.textTheme.bodyLarge,
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 20),
              const ButtonDialogAction(),
            ],
          ),
        ),
      ),
    );
  }
}
