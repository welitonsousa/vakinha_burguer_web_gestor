import 'package:dw10/src/core/ui/helpers/loader.dart';
import 'package:dw10/src/core/ui/helpers/message.dart';
import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask/mask.dart';

class PaymentEditDialog extends StatefulWidget {
  final PaymentModel? payment;
  final Future<void> Function(PaymentModel) saveOrEdit;

  const PaymentEditDialog({
    super.key,
    this.payment,
    required this.saveOrEdit,
  });

  @override
  State<PaymentEditDialog> createState() => _PaymentEditDialogState();
}

class _PaymentEditDialogState extends State<PaymentEditDialog>
    with Loader, Message {
  final nameController = TextEditingController();
  final form = GlobalKey<FormState>();
  bool enabled = false;

  @override
  void initState() {
    nameController.text = widget.payment?.name ?? '';
    enabled = widget.payment?.enabled ?? true;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(20),
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ' ${widget.payment != null ? "Editar" : "Criar"} forma de pagamento',
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: Mask.validations.generic,
                  autofocus: true,
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: enabled,
                      onChanged: (v) => setState(() => enabled = v!),
                    ),
                    const Text('Ativar/Desativar'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: Navigator.of(context).pop,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      child: const Text('Cancelar'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (form.currentState!.validate()) {
                          showLoader();
                          await Future.delayed(const Duration(seconds: 2));
                          await widget.saveOrEdit.call(PaymentModel(
                            id: widget.payment?.id,
                            name: nameController.text,
                            acronym: '',
                            enabled: enabled,
                          ));
                          hideLoader();
                          Modular.to.pop();
                        }
                      },
                      child: const Text('Salvar'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
