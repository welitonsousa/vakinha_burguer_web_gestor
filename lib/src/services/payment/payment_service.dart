import 'package:dw10/src/models/payment_model.dart';

abstract class PaymentService {
  Future<void> delete(int id);
  Future<int> save(PaymentModel payment);
  Future<List<PaymentModel>> ready();
  Future<PaymentModel> findById(int id);
}
