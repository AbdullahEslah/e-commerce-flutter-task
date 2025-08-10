import 'dart:collection';

import 'package:ecommerce_app/core/utils/network_utils/network_service.dart';
import 'package:ecommerce_app/features/products/domain/entities/products_entity.dart';
import 'package:ecommerce_app/features/products/domain/use_case/products_use_case.dart';
import 'package:flutter/foundation.dart';

import '../enum_state/products_enum_state.dart';

class ProductsProvider with ChangeNotifier {
  ProductsProvider(this.productsUseCase) {
    fetchProducts();
  }
  final ProductsUseCase productsUseCase;

  /// responsible for showing errorMessage
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// responsible for loading, failure or success state
  ProductsEnumState _productsState = ProductsEnumState.normal;
  ProductsEnumState get productsState => _productsState;

  /// products list
  List<ProductsEntity>? _productsList;
  UnmodifiableListView<ProductsEntity>? get productsList {
    return UnmodifiableListView(_productsList ?? []);
  }

  /// favorites set
  Set<ProductsEntity>? _favoritesSet = {};
  Set<ProductsEntity>? get favoritesSet => _favoritesSet;

  void addToFavorite(ProductsEntity product) {
    _favoritesSet?.add(product);
    notifyListeners();
  }

  void removeFromFavorite(ProductsEntity product) {
    _favoritesSet?.remove(product);
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  //  update products screen state
  void setProductsState(ProductsEnumState state) {
    _productsState = state;
    notifyListeners();
  }

  // Reset screen to normal state
  void resetProductsScreenState() {
    _productsState = ProductsEnumState.normal;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    setProductsState(ProductsEnumState.loading);
    Future.delayed(Duration(seconds: 2));
    final result = await productsUseCase.fetchProducts();

    switch (result) {
      case Ok(value: final products):
        debugPrint("$products");
        _productsList = products;
        setProductsState(ProductsEnumState.success);
        break;

      case Error(message: final e):
        debugPrint(e);
        setError(e.toString());
        setProductsState(ProductsEnumState.error);
        break;
    }
  }
}
