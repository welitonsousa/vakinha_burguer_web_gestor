import 'dart:html';
import 'dart:typed_data';

typedef UploadCallback = void Function(Uint8List, String);

class UploadFile {
  void selectFile(UploadCallback callback) {
    final input = FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      _handlerFileUpload(input, callback);
    });
  }

  void _handlerFileUpload(
      FileUploadInputElement input, UploadCallback callback) {
    if (input.files?.isNotEmpty ?? false) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        final bytes = Uint8List.fromList(reader.result as List<int>);
        callback.call(bytes, file.name);
      });
    }
  }
}
