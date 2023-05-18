import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/dtos/order_dto.dart';
import 'package:dw10/src/models/enums/order_status.dart';
import 'package:dw10/src/models/order_model.dart';
import 'package:dw10/src/services/order/order_service.dart';
import 'package:mobx/mobx.dart';

part 'order_controller.g.dart';

class OrderController = _OrderControllerBase with _$OrderController;

enum OrderStatusPage {
  initial,
  loading,
  success,
  error,
  hideDialog,
}

abstract class _OrderControllerBase with Store {
  final OrderService _orderService;

  _OrderControllerBase(this._orderService);

  @readonly
  EnumOrderStatus? _ordersFilterStatus;

  @readonly
  OrderDTO? _orderDetail;

  @readonly
  var _ordersStatusPage = OrderStatusPage.initial;

  @readonly
  var _message = "";

  @observable
  var _orders = <OrderModel>[];

  @computed
  List<OrderModel> get orders {
    if (_ordersFilterStatus == null) return _orders;
    return _orders.where((o) => o.status == _ordersFilterStatus).toList();
  }

  @action
  void changeFilterValue(EnumOrderStatus? value) {
    _ordersFilterStatus = value;
  }

  @action
  Future<void> findOrdersByDay() async {
    try {
      _ordersStatusPage = OrderStatusPage.loading;
      _orders = await _orderService.findAllOrdersByDay();
      _ordersStatusPage = OrderStatusPage.success;
    } catch (e) {
      _ordersStatusPage = OrderStatusPage.error;
      _message = "Erro ao buscar pedidos";
    }
  }

  @action
  Future<void> findOrderDTO(OrderModel order) async {
    try {
      _orderDetail = null;
      _ordersStatusPage = OrderStatusPage.loading;
      await Future.delayed(const Duration(seconds: 1));
      _orderDetail = await _orderService.orderMoreInfo(order);
      _ordersStatusPage = OrderStatusPage.success;
    } on RestClientException catch (e) {
      _ordersStatusPage = OrderStatusPage.error;
      _message = e.message;
    } catch (e) {
      _ordersStatusPage = OrderStatusPage.error;
      _message = "Erro ao buscar detalhes do pedido";
    }
  }

  Future<void> Function()? get cancel {
    final status = _orderDetail?.order.status;
    if (status == EnumOrderStatus.cancelado ||
        status == EnumOrderStatus.finalizado) return null;
    return () async => changeStatus(EnumOrderStatus.cancelado);
  }

  Future<void> Function()? get confirm {
    final status = _orderDetail?.order.status;
    if (status == EnumOrderStatus.cancelado ||
        status == EnumOrderStatus.confirmado ||
        status == EnumOrderStatus.finalizado) return null;
    return () async => changeStatus(EnumOrderStatus.confirmado);
  }

  Future<void> Function()? get finish {
    final status = _orderDetail?.order.status;
    if (status == EnumOrderStatus.cancelado ||
        status == EnumOrderStatus.pendente ||
        status == EnumOrderStatus.finalizado) return null;
    return () async => changeStatus(EnumOrderStatus.finalizado);
  }

  Future<void> changeStatus(EnumOrderStatus status) async {
    try {
      _ordersStatusPage = OrderStatusPage.loading;
      await _orderService.changeStatus(_orderDetail!.order.id, status);
      final index = _orders.indexWhere((o) => o.id == _orderDetail!.order.id);

      final updatedOrder = _orders[index].copyWith(status: status);
      _orders[index] = updatedOrder;
      _orders = [..._orders];

      _ordersStatusPage = OrderStatusPage.hideDialog;
    } catch (e) {
      _ordersStatusPage = OrderStatusPage.error;
      _message = "Atualizar status do pedido";
    }
  }
}
