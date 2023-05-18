import 'dart:developer';

import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/models/payment_model.dart';

import './payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RestClient restClient;
  PaymentRepositoryImpl({required this.restClient});

  @override
  Future<void> delete(int id) async {
    await restClient.auth.delete('/payment-types/$id');
  }

  @override
  Future<List<PaymentModel>> ready() async {
    final res = await restClient.auth.get('/payment-types');
    return res.map<PaymentModel>((p) => PaymentModel.fromMap(p)).toList();
  }

  @override
  Future<int> save(PaymentModel payment) async {
    if (payment.id == null) {
      final res =
          await restClient.auth.post('/payment-types/', data: payment.toMap());
      return res['id'];
    } else {
      await restClient.auth
          .put('/payment-types/${payment.id}', data: payment.toMap());
      return payment.id!;
    }
  }

  @override
  Future<PaymentModel> findById(int id) async {
    try {
      final res = await restClient.auth.get('/payment-types/$id');
      return PaymentModel.fromMap(res);
    } catch (e, s) {
      log(e.toString(), name: 'PaymentRepositoryImpl', error: e, stackTrace: s);
      throw RestClientException(message: 'Erro ao buscar pagamento');
    }
  }
}
