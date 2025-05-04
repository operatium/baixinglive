import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 定义一个枚举类型来区分图片来源
enum ImageSourceType { network, local }

@immutable
class Baixing_IconWidget extends StatelessWidget {
  final String mBaixing_url;
  final String mBaixing_defultCover = "images/baixing_def_cover.jpg";
  final ImageSourceType mBaixing_imageSourceType;
  final BoxFit mBaixing_boxFit;

  const Baixing_IconWidget({
    Key? key,
    required this.mBaixing_url,
    required this.mBaixing_imageSourceType,
    this.mBaixing_boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (mBaixing_imageSourceType) {
      case ImageSourceType.network:
        return CachedNetworkImage(
          imageUrl: mBaixing_url,
          fit: mBaixing_boxFit,
          imageBuilder: _getImage,
          placeholder: (context, url) {
            return Image.asset(
              mBaixing_defultCover,
              fit: mBaixing_boxFit,
            );
          },
        );
      case ImageSourceType.local:
        return Image.asset(
          mBaixing_url,
          fit: mBaixing_boxFit,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              mBaixing_defultCover,
              fit: mBaixing_boxFit,
            );
          },
        );
    }
  }

  Widget _getImage(BuildContext context, ImageProvider provider) {
    return Image(
      image: provider,
      fit: mBaixing_boxFit,
    );
  }
}