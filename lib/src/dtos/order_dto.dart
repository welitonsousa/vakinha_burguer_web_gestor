import 'package:dw10/src/models/order_model.dart';
import 'package:dw10/src/models/payment_model.dart';
import 'package:dw10/src/models/product_model.dart';
import 'package:dw10/src/models/user_model.dart';

class OrderDTO {
  final PaymentModel payment;
  final UserModel user;
  final OrderModel order;
  final List<ProductModel> products;
  OrderDTO({
    required this.user,
    required this.order,
    required this.products,
    required this.payment,
  });
}
