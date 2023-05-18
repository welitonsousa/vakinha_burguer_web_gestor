import 'package:dw10/src/dtos/order_dto.dart';
import 'package:dw10/src/models/enums/order_status.dart';
import 'package:dw10/src/models/order_model.dart';

abstract class OrderService {
  Future<List<OrderModel>> findAllOrdersByDay();
  Future<void> changeStatus(int id, EnumOrderStatus status);

  Future<OrderDTO> orderMoreInfo(OrderModel order);
}
