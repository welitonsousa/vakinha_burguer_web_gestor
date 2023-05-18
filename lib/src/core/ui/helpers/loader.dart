import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  void showLoader() {
    if (!_isLoading) {
      _isLoading = true;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) {
            return Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 40,
              ),
            );
          });
    }
  }

  void hideLoader() {
    if (_isLoading) {
      _isLoading = false;
      Modular.to.pop();
    }
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }
}
