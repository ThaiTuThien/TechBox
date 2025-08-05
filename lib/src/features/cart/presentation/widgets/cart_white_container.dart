import 'package:flutter/material.dart';

class CartWhiteContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool hasShadow;
  final Color? shadowColor;
  final double shadowOpacity;
  final double shadowSpreadRadius;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final double borderRadius;

  const CartWhiteContainer({
    super.key,
    required this.child,
    this.margin,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderWidth = 1.0,
    this.hasShadow = true,
    this.shadowColor,
    this.shadowOpacity = 0.1,
    this.shadowSpreadRadius = 1,
    this.shadowBlurRadius = 4,
    this.shadowOffset = const Offset(0, 2),
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: (shadowColor ?? Colors.grey).withValues(alpha: shadowOpacity),
                  spreadRadius: shadowSpreadRadius,
                  blurRadius: shadowBlurRadius,
                  offset: shadowOffset,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
} 