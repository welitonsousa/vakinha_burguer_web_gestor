import 'package:dw10/src/modules/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ButtonDialogAction extends StatelessWidget {
  const ButtonDialogAction({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<OrderController>();
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.finish,
            style: ButtonStyle(
              backgroundColor: controller.finish == null
                  ? null
                  : MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                  ),
                ),
              ),
            ),
            child: const Text('Finalizar'),
          ),
        ),
        Expanded(
            child: ElevatedButton(
          onPressed: controller.confirm,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          child: const Text('Confirmar'),
        )),
        Expanded(
          child: ElevatedButton(
            onPressed: controller.confirm,
            style: ButtonStyle(
              backgroundColor: controller.confirm == null
                  ? null
                  : MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
              ),
            ),
            child: const Text('Cancelar'),
          ),
        ),
      ],
    );
  }
}
