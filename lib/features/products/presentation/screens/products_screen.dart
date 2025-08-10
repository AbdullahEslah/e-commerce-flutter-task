import 'package:ecommerce_app/core/utils/extenions/navigation_extension.dart';
import 'package:ecommerce_app/features/products/presentation/products_widget_item/product_item.dart';
import 'package:ecommerce_app/features/products/presentation/provider/products_provider.dart';
import 'package:ecommerce_app/features/products/presentation/screens/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enum_state/products_enum_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.08,
        title: Text(
          "Latest Products",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: loadWidget(productsProvider, context)),
    );
  }

  Widget loadWidget(ProductsProvider productsProvider, BuildContext context) {
    switch (productsProvider.productsState) {
      case ProductsEnumState.normal:
        return buildMainView(productsProvider, context);

      case ProductsEnumState.loading:
        return const Center(
          child: CupertinoActivityIndicator(color: Colors.black54, radius: 15),
        );

      case ProductsEnumState.success:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          productsProvider.resetProductsScreenState();
        });
        return buildMainView(productsProvider, context);

      case ProductsEnumState.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                productsProvider.errorMessage ?? "",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
          productsProvider.resetProductsScreenState();
        });
        return buildMainView(productsProvider, context);
    }
  }

  GridView buildMainView(ProductsProvider productsProvider, context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.65,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: productsProvider.productsList?.length,
      itemBuilder: (context, index) {
        final productItem = productsProvider.productsList?[index];
        bool? isFavorite = productsProvider.favoritesSet
                ?.any((product) => product.id == productItem?.id) ??
            false;
        return InkWell(
          onTap: () => (productItem == null)
              ? debugPrint("item i empty")
              : context.push(ProductDetails(productItem: productItem)),
          child: ProductItem(
            key: Key("${productItem?.id ?? 0}"),
            product: productItem,
            onPressed: () {
              if (isFavorite == true) {
                productsProvider.removeFromFavorite(productItem!);
              } else {
                productsProvider.addToFavorite(productItem!);
              }
              debugPrint(
                  "favorites count is ${productsProvider.favoritesSet?.length}");
            },
            favoriteColor: (isFavorite) ? Colors.red : Colors.grey,
          ),
        );
      },
    );
  }
}
