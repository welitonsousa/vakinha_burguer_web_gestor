import 'dart:html';
import 'package:dw10/src/core/storage/storage.dart';

class SessionStorage extends Storage {
  @override
  void clear() {
    window.sessionStorage.clear();
  }

  @override
  String getData(String key) {
    return window.sessionStorage[key] ?? '';
  }

  @override
  void setData(String key, String value) {
    window.sessionStorage[key] = value;
  }
}
