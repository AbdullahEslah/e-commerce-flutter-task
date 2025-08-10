import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/features/products/domain/entities/products_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.productItem});
  final ProductsEntity productItem;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.08,
          title: Text(
            productItem.title,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          ),
        ),
        body: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: screenHeight * 0.4,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: (productItem.images.isNotEmpty &&
                        Uri.tryParse(productItem.images.first)?.isAbsolute ==
                            true)
                    ? productItem.images.first
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTFlhSWwrzGBZnqDlW7uLEEJWBhFc8sW_Ruw&s",
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
              SizedBox(
                height: screenHeight * 0.4,
                child: Column(spacing: 16, children: [
                  Center(
                    child: Text(
                      productItem.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(productItem.description),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${productItem.price}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ]));
  }
}
