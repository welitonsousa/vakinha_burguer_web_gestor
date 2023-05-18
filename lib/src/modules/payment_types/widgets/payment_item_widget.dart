import 'package:dw10/src/core/ui/style/theme.dart';
import 'package:dw10/src/models/payment_model.dart';
import 'package:flutter/material.dart';

class PaymentItemWidget extends StatelessWidget {
  final PaymentModel payment;
  final ValueChanged<PaymentModel> callback;
  const PaymentItemWidget({
    super.key,
    required this.callback,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(builder: (context, constrains) {
          return SizedBox(
            width: constrains.maxWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 60,
                  child: Image.asset(
                    'assets/images/icons/payment_${payment.acronym.toLowerCase()}_icon.png',
                    color: payment.enabled ? null : Colors.grey,
                    errorBuilder: (a, b, c) => Image.asset(
                      'assets/images/icons/payment_notfound_icon.png',
                      color: payment.enabled ? null : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: constrains.maxWidth * .4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forma de pagamento',
                        style: TextStyle(
                          color: payment.enabled ? null : Colors.grey,
                        ),
                      ),
                      Text(
                        payment.name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: payment.enabled ? null : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () => callback.call(payment),
                    child: const Icon(Icons.edit)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
