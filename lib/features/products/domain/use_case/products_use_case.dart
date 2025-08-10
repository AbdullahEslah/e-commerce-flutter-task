import 'package:ecommerce_app/core/utils/network_utils/network_service.dart';
import 'package:ecommerce_app/features/products/domain/entities/products_entity.dart';
import 'package:ecommerce_app/features/products/domain/repository/product_repository.dart';

class ProductsUseCase {
  ProductsUseCase(this.productRepository);
  final ProductRepository productRepository;

  Future<Result<List<ProductsEntity>>> fetchProducts() async {
    return await productRepository.fetchProducts();
  }
}
