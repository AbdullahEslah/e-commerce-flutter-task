import 'package:ecommerce_app/core/constants/apis.dart';
import 'package:ecommerce_app/core/constants/endpoint_enum.dart';
import 'package:ecommerce_app/features/products/data/models/product_listing_response_model.dart';

import '../../../../core/utils/network_utils/network_service.dart';

abstract class ProductsRemoteDataSource {
  Future<Result<List<ProductListingResponseModel>>> fetchProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  @override
  Future<Result<List<ProductListingResponseModel>>> fetchProducts() async {
    final request = await NetworkService()
        .requestList<ProductListingResponseModel>(
            url: Apis.getEndPointPath(EndPointsEnum.products),
            fromJson: (data) => ProductListingResponseModel.fromJson(data));
    return request;
  }
}
