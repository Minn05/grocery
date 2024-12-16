import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/const.dart';
import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularProductCard extends StatelessWidget {
  final Product product;
  const PopularProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 120,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 0.9,
                  child: CachedNetworkImage(
                    imageUrl: baseUrl + product.images.first,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error_outline),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      product.name,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
