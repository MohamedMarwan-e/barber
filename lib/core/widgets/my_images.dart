import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../resources/color_manager.dart'; // For loading spinner

class MyImage extends StatelessWidget {

  const MyImage(
      this.path,
      {
        super.key,
        this.height,
        this.width,
        this.fit = BoxFit.scaleDown,
        this.color,
        this.isNetwork = true,
        this.shape = false,
        this.radius = 6,
        this.borderRadius,
        this.isShadow = true,
      });

  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? color;
  final bool isNetwork;
  final bool shape;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        boxShadow: [
          if (isShadow)
            BoxShadow(
              color: Colors.black87.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
        ],
      ),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    if (path.endsWith('svg')) {
      return SvgPicture.asset(
        path,
        fit: fit,
        height: height,
        width: width,
        colorFilter: color == null ? null:
        ColorFilter.mode(
            color!,
            BlendMode.srcIn
        ),
      );
    } else if (path.startsWith('http') && isNetwork) {
      return shape ?
      CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) => const SpinKitRipple(
          color: primaryColor,
          size: 50,
        ),
        errorWidget: (context, url, error) => const BlankImageWidget(),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
      ) :
      CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) => const SpinKitRipple(
          color: primaryColor,
          size: 50,
        ),
        errorWidget: (context, url, error) => const BlankImageWidget(),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(radius),
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
      );
    } else if (path.endsWith('json')) {
      return Lottie.asset(
        path,
        fit: fit,
        height: height,
        width: width,
      );
    } else {
      return shape ?
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(path), fit: fit),
        ),
      ) :
      Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(radius),
          image: DecorationImage(image: AssetImage(path), fit: fit),
        ),
      );
    }
  }
}

class BlankImageWidget extends StatelessWidget {
  const BlankImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          elevation: 0.0,
        ),
      ),
    );
  }
}
