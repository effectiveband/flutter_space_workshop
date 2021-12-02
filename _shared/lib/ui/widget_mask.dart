import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'dart:ui';

/// Acts exactly like a `Stack` however the first child acts like an alpha mask when rendering the rest of the children
class RenderWidgetMask extends RenderStack {
  RenderWidgetMask(
      {List<RenderBox>? children,
      AlignmentGeometry alignment = AlignmentDirectional.topStart,
      TextDirection? textDirection,
      StackFit fit = StackFit.loose})
      : super(
            children: children,
            alignment: alignment,
            textDirection: textDirection,
            fit: fit);

  @override
  void paintStack(context, offset) {
    context.pushOpacity(offset, 255, paintEverything);
  }

  void paintContent(PaintingContext context, Offset offset) {
    RenderBox? child = (firstChild?.parentData as StackParentData).nextSibling;
    while (child != null) {
      final childParentData = child.parentData as StackParentData;
      context.paintChild(
          lastChild as RenderObject, offset + childParentData.offset);
      child = childParentData.nextSibling;
    }
  }

  void paintMask(PaintingContext context, Offset offset) {
    context.paintChild(firstChild as RenderObject,
        offset + (firstChild?.parentData as StackParentData).offset);
  }

  void paintEverything(PaintingContext context, Offset offset) {
    paintContent(context, offset);
    context.canvas
        .saveLayer(offset & size, Paint()..blendMode = BlendMode.dstIn);
    paintMask(context, offset);
    context.canvas.restore();
  }
}

/// Is a simple wrapper around the `Stack` widget that creates a custom stack based render object
class WidgetMask extends Stack {
  WidgetMask(
      {Key? key,
      AlignmentGeometry alignment = AlignmentDirectional.topStart,
      TextDirection? textDirection,
      StackFit fit = StackFit.loose,
      required Widget maskChild,
      required Widget child})
      : super(
          key: key,
          alignment: alignment,
          textDirection: textDirection,
          fit: fit,
          children: [maskChild, child],
        );

  @override
  RenderStack createRenderObject(context) {
    return RenderWidgetMask(
        alignment: alignment,
        textDirection: textDirection ?? Directionality.of(context),
        fit: fit);
  }

  @override
  void updateRenderObject(BuildContext context, RenderWidgetMask renderObject) {
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? Directionality.of(context)
      ..fit = fit;
  }
}
