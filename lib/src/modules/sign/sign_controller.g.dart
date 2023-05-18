// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignController on _SignControllerBase, Store {
  late final _$_messageAtom =
      Atom(name: '_SignControllerBase._message', context: context);

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

  late final _$_stateAtom =
      Atom(name: '_SignControllerBase._state', context: context);

  SignState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  SignState get _state => state;

  @override
  set _state(SignState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$signAsyncAction =
      AsyncAction('_SignControllerBase.sign', context: context);

  @override
  Future<void> sign({required String email, required String password}) {
    return _$signAsyncAction
        .run(() => super.sign(email: email, password: password));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
