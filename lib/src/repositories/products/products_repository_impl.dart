import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/core/rest_client/rest_client.dart';
import 'package:dw10/src/models/product_model.dart';

import './products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final RestClient _restClient;

  ProductsRepositoryImpl(this._restClient);

  @override
  Future<void> delete(int id) async {
    try {
      await _restClient.auth.put('/products/$id', data: {
        'enabled': false,
      });
    } catch (e, s) {
      log('Erro ao desabilitar produto: $e', stackTrace: s);
      throw RestClientException();
    }
  }

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final res = await _restClient.auth.get('/products');
      return res.map<ProductModel>((e) => ProductModel.fromMap(e)).toList();
    } catch (e, s) {
      log('Erro ao buscar produtos: $e', stackTrace: s);
      throw RestClientException();
    }
  }

  @override
  Future<ProductModel> findById(int id) async {
    try {
      final res = await _restClient.auth.get('/products/$id');
      return ProductModel.fromMap(res);
    } catch (e, s) {
      log('Erro ao buscar produto: $e', stackTrace: s);
      throw RestClientException();
    }
  }

  @override
  Future<int> save(ProductModel product) async {
    try {
      if (product.id != null) {
        await _restClient.auth
            .put('/products/${product.id}', data: product.toMap());
        return product.id!;
      } else {
        final res =
            await _restClient.auth.post('/products', data: product.toMap());
        return res['id'];
      }
    } catch (e, s) {
      log('Erro ao salvar ou editar produto: $e', stackTrace: s);
      throw RestClientException();
    }
  }

  @override
  Future<String> uploadFile(Uint8List file) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(file, filename: 'product.png'),
    });
    try {
      final res = await _restClient.auth.post('/uploads', formData: formData);
      return res['url'];
    } catch (e, s) {
      log('Erro ao fazer upload de imagem: $e', stackTrace: s);
      throw RestClientException();
    }
  }
}
