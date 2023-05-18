import 'package:dw10/src/core/ui/helpers/loader.dart';
import 'package:dw10/src/core/ui/helpers/message.dart';
import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/modules/payment_types/payment_types_controller.dart';
import 'package:dw10/src/modules/payment_types/widgets/payment_edit_dialog.dart';
import 'package:dw10/src/modules/payment_types/widgets/payment_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class PaymentTypesPage extends StatefulWidget {
  const PaymentTypesPage({super.key});

  @override
  State<PaymentTypesPage> createState() => _PaymentTypesPageState();
}

class _PaymentTypesPageState extends State<PaymentTypesPage>
    with Loader, Message {
  final controller = Modular.get<PaymentTypesController>();
  late final ReactionDisposer disposerReaction;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.ready();
      appStates();
    });
  }

  @override
  void dispose() {
    disposerReaction();
    super.dispose();
  }

  void appStates() {
    disposerReaction = reaction((_) => controller.status, (_) {
      switch (controller.status) {
        case PaymentTypesStatus.initial:
          break;
        case PaymentTypesStatus.loading:
          showLoader();
          break;
        case PaymentTypesStatus.success:
          hideLoader();
          break;
        case PaymentTypesStatus.error:
          hideLoader();
          showMessage(controller.message, type: MessageType.failure);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (context) {
                return Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<bool?>(
                    value: controller.filter,
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.filter_alt),
                    onChanged: controller.changeFilter,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Todos')),
                      DropdownMenuItem(value: true, child: Text('Ativos')),
                      DropdownMenuItem(value: false, child: Text('Inativos')),
                    ],
                  ),
                );
              }),
              Text('Tipos de pagamentos', style: context.textTheme.titleLarge),
              OutlinedButton(
                child: const Text('Adicionar'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (c) => PaymentEditDialog(
                      saveOrEdit: (v) async {
                        await controller.saveOrEditPayment(v);
                        showMessage(
                            'Tipo de pagamento cadastrado com sucesso!');
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Observer(
              builder: (c) => GridView.builder(
                itemCount: controller.paymentsList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (c, i) => PaymentItemWidget(
                  payment: controller.paymentsList[i],
                  callback: (payment) {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return PaymentEditDialog(
                          payment: payment,
                          saveOrEdit: (v) async {
                            await controller.saveOrEditPayment(v);
                            showMessage(
                                'Tipo de pagamento atualizado com sucesso!');
                          },
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
