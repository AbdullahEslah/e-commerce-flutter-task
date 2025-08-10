import 'package:ecommerce_app/core/utils/network_utils/network_service.dart';
import 'package:ecommerce_app/features/products/domain/entities/products_entity.dart';
import 'package:ecommerce_app/features/products/domain/repository/product_repository.dart';

import '../remote_data_source/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductRepository {
  ProductsRepositoryImpl(this.productsRemoteDataSource);

  final ProductsRemoteDataSource productsRemoteDataSource;
  @override
  Future<Result<List<ProductsEntity>>> fetchProducts() async {
    return await productsRemoteDataSource.fetchProducts();
  }
}
