import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  const BannerCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: '$baseUrl$imageUrl',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}