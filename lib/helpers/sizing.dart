import 'package:flutter/material.dart';

const double kTabBarHeight = 50.0;

class Sizing {
  static double remaining({
    @required parentKey,
    @required childKey,
    @required context,
  }) {
    final RenderBox renderBoxChild = childKey.currentContext.findRenderObject();
    final childSize = renderBoxChild.size;

    final RenderBox _renderParent = parentKey.currentContext.findRenderObject();
    final parentSize = _renderParent.size;

    final remainingSpace = (parentSize?.height ?? 0) -
        (childSize?.height ?? 0) -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return remainingSpace;
  }
}
