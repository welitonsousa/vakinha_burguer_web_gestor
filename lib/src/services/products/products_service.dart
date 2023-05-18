import 'package:dw10/src/models/product_model.dart';
import 'package:flutter/services.dart';

abstract class ProductService {
  Future<List<ProductModel>> findAllProducts();
  Future<ProductModel> findById(int id);
  Future<int> save(ProductModel product);
  Future<void> delete(int id);
  Future<String> upload(Uint8List file);
}
