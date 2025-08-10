import 'package:ecommerce_app/core/utils/network_utils/network_service.dart';
import 'package:ecommerce_app/features/products/domain/entities/products_entity.dart';

abstract class ProductRepository {
  Future<Result<List<ProductsEntity>>> fetchProducts();
}
