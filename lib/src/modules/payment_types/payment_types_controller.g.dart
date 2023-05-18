// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_types_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaymentTypesController on _PaymentTypesControllerBase, Store {
  late final _$_paymentsAtom =
      Atom(name: '_PaymentTypesControllerBase._payments', context: context);

  List<PaymentModel> get payments {
    _$_paymentsAtom.reportRead();
    return super._payments;
  }

  @override
  List<PaymentModel> get _payments => payments;

  @override
  set _payments(List<PaymentModel> value) {
    _$_paymentsAtom.reportWrite(value, super._payments, () {
      super._payments = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: '_PaymentTypesControllerBase._status', context: context);

  PaymentTypesStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  PaymentTypesStatus get _status => status;

  @override
  set _status(PaymentTypesStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_messageAtom =
      Atom(name: '_PaymentTypesControllerBase._message', context: context);

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

  late final _$_filterAtom =
      Atom(name: '_PaymentTypesControllerBase._filter', context: context);

  bool? get filter {
    _$_filterAtom.reportRead();
    return super._filter;
  }

  @override
  bool? get _filter => filter;

  @override
  set _filter(bool? value) {
    _$_filterAtom.reportWrite(value, super._filter, () {
      super._filter = value;
    });
  }

  late final _$readyAsyncAction =
      AsyncAction('_PaymentTypesControllerBase.ready', context: context);

  @override
  Future<void> ready() {
    return _$readyAsyncAction.run(() => super.ready());
  }

  late final _$saveOrEditPaymentAsyncAction = AsyncAction(
      '_PaymentTypesControllerBase.saveOrEditPayment',
      context: context);

  @override
  Future<void> saveOrEditPayment(PaymentModel payment) {
    return _$saveOrEditPaymentAsyncAction
        .run(() => super.saveOrEditPayment(payment));
  }

  late final _$_PaymentTypesControllerBaseActionController =
      ActionController(name: '_PaymentTypesControllerBase', context: context);

  @override
  void changeFilter(bool? value) {
    final _$actionInfo = _$_PaymentTypesControllerBaseActionController
        .startAction(name: '_PaymentTypesControllerBase.changeFilter');
    try {
      return super.changeFilter(value);
    } finally {
      _$_PaymentTypesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
