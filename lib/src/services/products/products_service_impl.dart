import 'dart:typed_data';

import 'package:dw10/src/models/product_model.dart';
import 'package:dw10/src/repositories/products/products_repository.dart';

import 'products_service.dart';

class ProductServiceImpl extends ProductService {
  final ProductsRepository _productsRepository;

  ProductServiceImpl(this._productsRepository);

  @override
  Future<void> delete(int id) => _productsRepository.delete(id);

  @override
  Future<List<ProductModel>> findAllProducts() =>
      _productsRepository.findAllProducts();

  @override
  Future<int> save(ProductModel product) => _productsRepository.save(product);

  @override
  Future<String> upload(Uint8List file) => _productsRepository.uploadFile(file);

  @override
  Future<ProductModel> findById(int id) => _productsRepository.findById(id);
}
