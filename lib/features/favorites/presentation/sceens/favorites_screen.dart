import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../products/presentation/products_widget_item/product_item.dart';
import '../../../products/presentation/provider/products_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final favoritesList = productsProvider.favoritesSet?.toList() ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            "Favorites"),
      ),
      body: (favoritesList.isEmpty)
          ? Center(
              child: Text(
                "No favorites added yet\n start adding now",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            )
          : SizedBox(
              height: screenHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: favoritesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final favoriteItem = favoritesList[index];

                    bool isFavorite = productsProvider.favoritesSet
                            ?.any((product) => product.id == favoriteItem.id) ??
                        false;
                    return AspectRatio(
                      aspectRatio: 5 / 3,
                      child: SizedBox(
                        height: screenHeight * 0.4,
                        // width: 200,
                        child: ProductItem(
                          imageHeight: 100,
                          product: favoriteItem,
                          onPressed: () {
                            if (isFavorite) {
                              productsProvider.removeFromFavorite(favoriteItem);
                            } else {
                              productsProvider.addToFavorite(favoriteItem);
                            }

                            debugPrint(
                                "favorites count is ${productsProvider.favoritesSet?.length}");
                          },
                          favoriteColor: isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
