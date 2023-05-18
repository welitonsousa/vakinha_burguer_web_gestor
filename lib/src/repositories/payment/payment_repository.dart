import 'package:dw10/src/models/payment_model.dart';

abstract class PaymentRepository {
  Future<int> save(PaymentModel payment);
  Future<PaymentModel> findById(int id);
  Future<void> delete(int id);
  Future<List<PaymentModel>> ready();
}
