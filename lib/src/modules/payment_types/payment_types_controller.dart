import 'package:dw10/src/models/payment_model.dart';
import 'package:mobx/mobx.dart';
import 'package:dw10/src/services/payment/payment_service.dart';

part 'payment_types_controller.g.dart';

class PaymentTypesController = _PaymentTypesControllerBase
    with _$PaymentTypesController;

enum PaymentTypesStatus { initial, loading, success, error }

abstract class _PaymentTypesControllerBase with Store {
  final PaymentService service;
  _PaymentTypesControllerBase({required this.service});

  @readonly
  var _payments = <PaymentModel>[];

  List<PaymentModel> get paymentsList {
    if (_filter == null) return _payments;
    return _payments.where((e) => e.enabled == _filter).toList();
  }

  @readonly
  var _status = PaymentTypesStatus.initial;

  @readonly
  var _message = '';

  @readonly
  bool? _filter;

  @action
  void changeFilter(bool? value) {
    _filter = value;
  }

  @action
  Future<void> ready() async {
    try {
      _status = PaymentTypesStatus.loading;
      _payments = await service.ready();
      _status = PaymentTypesStatus.success;
    } catch (e) {
      _status = PaymentTypesStatus.error;
      _message = "Erro ao carregar os pagamentos";
    }
  }

  @action
  Future<void> saveOrEditPayment(PaymentModel payment) async {
    try {
      final id = await service.save(payment);
      if (payment.id == null) {
        _payments = [..._payments, payment.copyWith(id: id)];
      } else {
        final index = _payments.indexWhere((p) => p.id == payment.id);
        _payments[index] = payment;
        _payments = [..._payments];
      }
      await Future.delayed(Duration.zero);
    } catch (e) {
      if (payment.id != null) _message = "Erro ao salvar o pagamento";
      if (payment.id == null) _message = "Erro ao criar o pagamento";
      _status = PaymentTypesStatus.error;
    }
  }
}
