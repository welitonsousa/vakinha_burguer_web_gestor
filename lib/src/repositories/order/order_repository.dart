import 'package:dw10/src/models/enums/order_status.dart';
import 'package:dw10/src/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> findAllOrdersByDay();
  Future<void> changeStatus(int id, EnumOrderStatus status);
}
