import 'package:dw10/src/core/ui/helpers/loader.dart';
import 'package:dw10/src/core/ui/helpers/message.dart';
import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/models/enums/order_status.dart';
import 'package:dw10/src/modules/order/widgets/order_detail_dialog.dart';
import 'package:dw10/src/modules/order/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'order_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Message {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer disposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      disposer = reaction((_) => controller.ordersStatusPage, (status) {
        switch (status) {
          case OrderStatusPage.loading:
            showLoader();
            break;
          case OrderStatusPage.success:
            hideLoader();
            break;
          case OrderStatusPage.error:
            hideLoader();
            showMessage(controller.message, type: MessageType.failure);
            break;
          case OrderStatusPage.initial:
            break;
          case OrderStatusPage.hideDialog:
            hideLoader();
            break;
        }
      });
      await controller.findOrdersByDay();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Observer(builder: (context) {
                  return DropdownButton<EnumOrderStatus?>(
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.filter_alt),
                    onChanged: (v) {
                      setState(() {
                        controller.changeFilterValue(v);
                      });
                    },
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Todos')),
                      ...EnumOrderStatus.values
                          .map(
                            (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.name,
                                  style: TextStyle(color: e.color),
                                )),
                          )
                          .toList(),
                    ],
                  );
                }),
              ),
              Text(
                "Pedidos do dia",
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Observer(builder: (context) {
              return GridView.builder(
                itemCount: controller.orders.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450,
                  mainAxisExtent: 80,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (c, i) => OrderItemWidget(
                  order: controller.orders[i],
                  onTap: () async {
                    await controller.findOrderDTO(controller.orders[i]);
                    showMoreInfoDialog();
                  },
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Future<void> showMoreInfoDialog() async {
    if (controller.orderDetail == null) return;
    await showDialog(
      context: context,
      builder: (b) {
        return OrderDetailDialog(
          orderDetail: controller.orderDetail!,
        );
      },
    );
  }
}
