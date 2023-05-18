import 'package:dw10/src/core/exceptions/rest_client_exception.dart';
import 'package:dw10/src/models/product_model.dart';
import 'package:dw10/src/services/products/products_service.dart';
import 'package:mobx/mobx.dart';

part 'products_controller.g.dart';

enum ProductStatus { initial, loading, error, success }

class ProductsController = _ProductsControllerBase with _$ProductsController;

abstract class _ProductsControllerBase with Store {
  final ProductService _productService;
  _ProductsControllerBase(this._productService);

  @observable
  var _allProducts = <ProductModel>[];

  @readonly
  var _search = '';

  @readonly
  var _message = '';

  @readonly
  var _status = ProductStatus.initial;

  @computed
  List<ProductModel> get products => _allProducts
      .where((e) => e.name.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @action
  String changeSearch(String value) => _search = value;

  @action
  Future<void> findAllProducts() async {
    try {
      _status = ProductStatus.loading;
      _allProducts = await _productService.findAllProducts();
      _status = ProductStatus.success;
    } on RestClientException {
      _status = ProductStatus.error;
      _message = 'Erro ao buscar produtos';
    } catch (e) {
      _message = 'Não foi possível buscar os produtos';
      _status = ProductStatus.error;
    }
  }

  @action
  Future<void> delete(int product) async {
    await _productService.delete(product);
  }

  @action
  Future<void> updateOrCreateProduct() async {}
}
