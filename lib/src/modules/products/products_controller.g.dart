// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductsController on _ProductsControllerBase, Store {
  Computed<List<ProductModel>>? _$productsComputed;

  @override
  List<ProductModel> get products =>
      (_$productsComputed ??= Computed<List<ProductModel>>(() => super.products,
              name: '_ProductsControllerBase.products'))
          .value;

  late final _$_allProductsAtom =
      Atom(name: '_ProductsControllerBase._allProducts', context: context);

  @override
  List<ProductModel> get _allProducts {
    _$_allProductsAtom.reportRead();
    return super._allProducts;
  }

  @override
  set _allProducts(List<ProductModel> value) {
    _$_allProductsAtom.reportWrite(value, super._allProducts, () {
      super._allProducts = value;
    });
  }

  late final _$_searchAtom =
      Atom(name: '_ProductsControllerBase._search', context: context);

  String get search {
    _$_searchAtom.reportRead();
    return super._search;
  }

  @override
  String get _search => search;

  @override
  set _search(String value) {
    _$_searchAtom.reportWrite(value, super._search, () {
      super._search = value;
    });
  }

  late final _$_messageAtom =
      Atom(name: '_ProductsControllerBase._message', context: context);

  String get message {
    _$_messageAtom.reportRead();
    return super._message;
  }

  @override
  String get _message => message;

  @override
  set _message(String value) {
    _$_messageAtom.reportWrite(value, super._message, () {
      super._message = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: '_ProductsControllerBase._status', context: context);

  ProductStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  ProductStatus get _status => status;

  @override
  set _status(ProductStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$findAllProductsAsyncAction =
      AsyncAction('_ProductsControllerBase.findAllProducts', context: context);

  @override
  Future<void> findAllProducts() {
    return _$findAllProductsAsyncAction.run(() => super.findAllProducts());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_ProductsControllerBase.delete', context: context);

  @override
  Future<void> delete(int product) {
    return _$deleteAsyncAction.run(() => super.delete(product));
  }

  late final _$updateOrCreateProductAsyncAction = AsyncAction(
      '_ProductsControllerBase.updateOrCreateProduct',
      context: context);

  @override
  Future<void> updateOrCreateProduct() {
    return _$updateOrCreateProductAsyncAction
        .run(() => super.updateOrCreateProduct());
  }

  late final _$_ProductsControllerBaseActionController =
      ActionController(name: '_ProductsControllerBase', context: context);

  @override
  String changeSearch(String value) {
    final _$actionInfo = _$_ProductsControllerBaseActionController.startAction(
        name: '_ProductsControllerBase.changeSearch');
    try {
      return super.changeSearch(value);
    } finally {
      _$_ProductsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
