import 'package:dw10/src/dtos/order_dto.dart';

import 'package:dw10/src/models/enums/order_status.dart';

import 'package:dw10/src/models/order_model.dart';
import 'package:dw10/src/models/payment_model.dart';
import 'package:dw10/src/models/product_model.dart';
import 'package:dw10/src/models/user_model.dart';
import 'package:dw10/src/repositories/order/order_repository.dart';
import 'package:dw10/src/repositories/payment/payment_repository.dart';
import 'package:dw10/src/repositories/products/products_repository.dart';
import 'package:dw10/src/repositories/user/user_repository.dart';

import './order_service.dart';

class OrderServiceImpl implements OrderService {
  final OrderRepository _orderRepository;
  final UserRepository _userRepository;
  final ProductsRepository _productsRepository;
  final PaymentRepository _paymentRepository;

  OrderServiceImpl(
    this._orderRepository,
    this._userRepository,
    this._productsRepository,
    this._paymentRepository,
  );

  @override
  Future<void> changeStatus(int id, EnumOrderStatus status) =>
      _orderRepository.changeStatus(id, status);

  @override
  Future<List<OrderModel>> findAllOrdersByDay() =>
      _orderRepository.findAllOrdersByDay();

  @override
  Future<OrderDTO> orderMoreInfo(OrderModel order) async {
    final res = await Future.wait([
      _userRepository.findById(order.userId),
      _productsRepository.findAllProducts(),
      _paymentRepository.findById(order.paymentMethodId)
    ]);

    return OrderDTO(
      user: res[0] as UserModel,
      order: order,
      payment: res[2] as PaymentModel,
      products: (res[1] as List<ProductModel>)
          .where((p) => order.products.any((i) => i.id == p.id))
          .toList(),
    );
  }
}
