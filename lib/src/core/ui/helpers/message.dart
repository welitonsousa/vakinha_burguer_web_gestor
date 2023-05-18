import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

enum MessageType {
  success,
  failure,
  warning,
  info;

  String get label {
    if (this == MessageType.success) return 'Sucesso';
    if (this == MessageType.failure) return 'Ops...';
    if (this == MessageType.info) return 'Atenção';
    return 'Atenção';
  }

  ContentType get contentType {
    if (this == MessageType.success) return ContentType.success;
    if (this == MessageType.failure) return ContentType.failure;
    if (this == MessageType.info) return ContentType.help;
    return ContentType.warning;
  }
}

mixin Message<T extends StatefulWidget> on State<T> {
  void showMessage(String message, {MessageType type = MessageType.success}) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: type.label,
        message: message,
        contentType: type.contentType,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
