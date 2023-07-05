import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.imageUrl});
  final String imageUrl;
  final String _imageNotFound = 'fotoğraf bulunamadı';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Row(
            children: [
              Text(_imageNotFound),
              const Icon(Icons.error),
            ],
          ),
        ),
      ),
    );
  }
}
