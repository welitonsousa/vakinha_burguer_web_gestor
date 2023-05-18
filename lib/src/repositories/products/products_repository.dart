import 'dart:typed_data';

import 'package:dw10/src/models/product_model.dart';

abstract class ProductsRepository {
  Future<List<ProductModel>> findAllProducts();
  Future<ProductModel> findById(int id);
  Future<int> save(ProductModel product);
  Future<void> delete(int id);
  Future<String> uploadFile(Uint8List file);
}
