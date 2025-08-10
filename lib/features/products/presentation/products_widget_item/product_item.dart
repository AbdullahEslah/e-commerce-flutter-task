import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/products/domain/entities/products_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.product,
      required this.onPressed,
      required this.favoriteColor,
      this.imageHeight});
  final ProductsEntity? product;
  final VoidCallback onPressed;
  final Color favoriteColor;
  final double? imageHeight;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 8,
          children: [
            SizedBox(
              height: imageHeight,
              //flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: product?.images.first ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTFlhSWwrzGBZnqDlW7uLEEJWBhFc8sW_Ruw&s",
                  placeholder: (context, url) =>
                      //  put it in the center
                      Transform.scale(
                    scale: 0.5,
                    child: const CupertinoActivityIndicator(color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        size: 40, color: Colors.grey),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Text(
                product?.title ?? "",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product?.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  IconButton(
                    icon: Icon(
                        // product.isFavorite
                        //     ?
                        Icons.favorite,
                        // : Icons.favorite_border,
                        color:
                            // product.isFavorite ?
                            favoriteColor
                        // :
                        // Colors.grey,
                        ),
                    onPressed: () {
                      onPressed();
                      // setState(() {
                      //   product.isFavorite = !product.isFavorite;
                      // });
                    },
                  )
                ],
              ),
            )

            // زر المفضلة
          ],
        ),
      ),
    );
  }
}
