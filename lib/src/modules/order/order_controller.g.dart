// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderController on _OrderControllerBase, Store {
  Computed<List<OrderModel>>? _$ordersComputed;

  @override
  List<OrderModel> get orders =>
      (_$ordersComputed ??= Computed<List<OrderModel>>(() => super.orders,
              name: '_OrderControllerBase.orders'))
          .value;

  late final _$_ordersFilterStatusAtom =
      Atom(name: '_OrderControllerBase._ordersFilterStatus', context: context);

  EnumOrderStatus? get ordersFilterStatus {
    _$_ordersFilterStatusAtom.reportRead();
    return super._ordersFilterStatus;
  }

  @override
  EnumOrderStatus? get _ordersFilterStatus => ordersFilterStatus;

  @override
  set _ordersFilterStatus(EnumOrderStatus? value) {
    _$_ordersFilterStatusAtom.reportWrite(value, super._ordersFilterStatus, () {
      super._ordersFilterStatus = value;
    });
  }

  late final _$_orderDetailAtom =
      Atom(name: '_OrderControllerBase._orderDetail', context: context);

  OrderDTO? get orderDetail {
    _$_orderDetailAtom.reportRead();
    return super._orderDetail;
  }

  @override
  OrderDTO? get _orderDetail => orderDetail;

  @override
  set _orderDetail(OrderDTO? value) {
    _$_orderDetailAtom.reportWrite(value, super._orderDetail, () {
      super._orderDetail = value;
    });
  }

  late final _$_ordersStatusPageAtom =
      Atom(name: '_OrderControllerBase._ordersStatusPage', context: context);

  OrderStatusPage get ordersStatusPage {
    _$_ordersStatusPageAtom.reportRead();
    return super._ordersStatusPage;
  }

  @override
  OrderStatusPage get _ordersStatusPage => ordersStatusPage;

  @override
  set _ordersStatusPage(OrderStatusPage value) {
    _$_ordersStatusPageAtom.reportWrite(value, super._ordersStatusPage, () {
      super._ordersStatusPage = value;
    });
  }

  late final _$_messageAtom =
      Atom(name: '_OrderControllerBase._message', context: context);

  String get message {
    _$_messageAtom.reportRead();
    return super._message;
  }

  @override
  String get _message => message;

  @override
  set _message(String value) {
    _$_messageAtom.reportWrite(value, super._message, () {
      super._message = value;
    });
  }

  late final _$_ordersAtom =
      Atom(name: '_OrderControllerBase._orders', context: context);

  @override
  List<OrderModel> get _orders {
    _$_ordersAtom.reportRead();
    return super._orders;
  }

  @override
  set _orders(List<OrderModel> value) {
    _$_ordersAtom.reportWrite(value, super._orders, () {
      super._orders = value;
    });
  }

  late final _$findOrdersByDayAsyncAction =
      AsyncAction('_OrderControllerBase.findOrdersByDay', context: context);

  @override
  Future<void> findOrdersByDay() {
    return _$findOrdersByDayAsyncAction.run(() => super.findOrdersByDay());
  }

  late final _$findOrderDTOAsyncAction =
      AsyncAction('_OrderControllerBase.findOrderDTO', context: context);

  @override
  Future<void> findOrderDTO(OrderModel order) {
    return _$findOrderDTOAsyncAction.run(() => super.findOrderDTO(order));
  }

  late final _$_OrderControllerBaseActionController =
      ActionController(name: '_OrderControllerBase', context: context);

  @override
  void changeFilterValue(EnumOrderStatus? value) {
    final _$actionInfo = _$_OrderControllerBaseActionController.startAction(
        name: '_OrderControllerBase.changeFilterValue');
    try {
      return super.changeFilterValue(value);
    } finally {
      _$_OrderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orders: ${orders}
    ''';
  }
}
