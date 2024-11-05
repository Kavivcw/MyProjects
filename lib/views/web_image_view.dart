import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sparebess/shared/constant.dart';

class WebImageView extends StatelessWidget {
  const WebImageView(this.imageUrl, {super.key, this.fit});
  final String? imageUrl;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    final placeholder = Image.asset('logo_red'.png);
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl ?? '',
      placeholder: (_, __) => placeholder,
      errorWidget: (con, string, object) => placeholder,
    );
  }
}
