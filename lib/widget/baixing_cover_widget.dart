import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

@immutable
class Baixing_CoverWidget extends StatelessWidget {
  final String mBaixing_url;
  final String mBaixing_defultCover = "images/baixing_def_cover.jpg";

  const Baixing_CoverWidget({Key? key, required this.mBaixing_url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: mBaixing_url,
      fit: BoxFit.cover,
      imageBuilder: (context, provider) {
        return Image(
          image: provider,
          fit: BoxFit.cover,
        );
      },
      placeholder: (context, url) {
        return Image.asset(
          mBaixing_defultCover,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
