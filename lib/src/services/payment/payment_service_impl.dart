import 'package:dw10/src/models/payment_model.dart';
import 'package:dw10/src/repositories/payment/payment_repository.dart';

import './payment_service.dart';

class PaymentServiceImpl implements PaymentService {
  final PaymentRepository repository;
  PaymentServiceImpl({required this.repository});

  @override
  Future<void> delete(int id) => repository.delete(id);

  @override
  Future<List<PaymentModel>> ready() => repository.ready();

  @override
  Future<int> save(PaymentModel payment) => repository.save(payment);

  @override
  Future<PaymentModel> findById(int id) => repository.findById(id);
}
