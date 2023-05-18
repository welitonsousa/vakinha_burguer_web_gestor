import 'dart:developer';
import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/models/enums/order_status.dart';

import 'package:dw10/src/models/order_model.dart';

import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final RestClient _restClient;

  OrderRepositoryImpl(this._restClient);

  @override
  Future<void> changeStatus(int id, EnumOrderStatus status) async {
    try {
      await _restClient.auth
          .put('/orders/$id', data: {'status': status.acronym});
    } on Exception catch (e, s) {
      log('Erro ao mudar status do pedido', error: e, stackTrace: s);
      throw RestClientException(message: 'Erro ao mudar status do pedido');
    }
  }

  @override
  Future<List<OrderModel>> findAllOrdersByDay() async {
    try {
      final date = DateTime.now();
      final res = await _restClient.auth.get('/orders', query: {
        'date': DateTime(date.year, date.month, date.day).toIso8601String(),
      });
      return res.map<OrderModel>((e) => OrderModel.fromMap(e)).toList();
    } on Exception catch (e, s) {
      log('Erro ao mudar status do pedido', error: e, stackTrace: s);
      throw RestClientException(message: 'Erro ao buscar pedidos');
    }
  }
}
