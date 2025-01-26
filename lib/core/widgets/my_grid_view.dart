import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyGridView extends StatelessWidget {

  const MyGridView({
    required this.width,
    required this.childBuilder,
    required this.listLength,
    this.crossAxisCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.haveFittedBox = true,
    this.verticalAnimation = true,
    this.physics,
    super.key,
  });

  final double width;
  final int? crossAxisCount;
  final Widget Function(int index) childBuilder;
  final int listLength;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final bool? haveFittedBox;
  final bool? verticalAnimation;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: width ,
        child: AnimationLimiter(
          child: MasonryGridView.count(
              shrinkWrap: true,
              physics:physics?? const BouncingScrollPhysics(),
              crossAxisCount:  crossAxisCount?? 2,
              mainAxisSpacing: mainAxisSpacing ?? 12,
              crossAxisSpacing: crossAxisSpacing ?? 20,
              itemCount: listLength,
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: verticalAnimation! ? 50 : null,
                        horizontalOffset: !verticalAnimation! ? 50 : null,
                        child: FadeInAnimation(
                            child: haveFittedBox!?
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: childBuilder(index),
                            ):
                            childBuilder(index)
                        ),
                      )
                  )
          ),
        ),
      ),
    );
  }
}