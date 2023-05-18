import 'dart:typed_data';

import 'package:dw10/src/models/product_model.dart';
import 'package:dw10/src/services/products/products_service.dart';
import 'package:mobx/mobx.dart';

part 'product_detail_controller.g.dart';

class ProductDetailController = _ProductDetailControllerBase
    with _$ProductDetailController;

enum ProductDetailState { initial, loading, success, error }

abstract class _ProductDetailControllerBase with Store {
  final ProductService _service;
  _ProductDetailControllerBase(this._service);

  @readonly
  Uint8List? _image;

  @readonly
  var _urlImage = "";

  @readonly
  var _status = ProductDetailState.initial;

  @readonly
  var _message = "";

  void selectFile(Uint8List file) {
    _image = file;
  }

  Future<ProductModel?> findProduct(int id) async {
    try {
      _status = ProductDetailState.loading;
      final res = await _service.findById(id);
      _urlImage = res.image ?? '';
      _status = ProductDetailState.success;
      return res;
    } catch (e) {
      _status = ProductDetailState.error;
      _message = "Erro ao buscar produto";
    }
    return null;
  }

  Future<void> delete(int id) async {
    try {
      _status = ProductDetailState.loading;
      await _service.delete(id);
      _status = ProductDetailState.success;
    } catch (e) {
      _status = ProductDetailState.error;
      _message = "Erro ao deletar produto";
      rethrow;
    }
  }

  Future<void> save(ProductModel product) async {
    if (_image == null || (product.id == null && _urlImage.isEmpty)) {
      _message = "Selecione uma imagem";
      _status = ProductDetailState.error;
      throw "Selecione uma imagem";
    } else {
      try {
        _status = ProductDetailState.loading;
        if (product.image?.isEmpty ?? true) {
          final url = await _service.upload(_image!);
          await _service.save(product.copyWith(image: url));
        } else {
          await _service.save(product);
        }
        _status = ProductDetailState.success;
      } catch (e) {
        _status = ProductDetailState.error;
        _message = "Erro ao salvar produto";
        rethrow;
      }
    }
  }
}
