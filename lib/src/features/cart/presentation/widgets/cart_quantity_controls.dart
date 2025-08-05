import 'package:flutter/material.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/core/theme/app_colors.dart';

class CartQuantityControls extends StatefulWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  const CartQuantityControls({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<CartQuantityControls> createState() => _CartQuantityControlsState();
}

class _CartQuantityControlsState extends State<CartQuantityControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onButtonPressed(VoidCallback? onTap) {
    if (onTap != null) {
      _animationController.forward().then((_) {
        _animationController.reverse();
        onTap();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Row(
            children: [
              // Minus Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: widget.quantity > 1 
                      ? () => _onButtonPressed(() => widget.onQuantityChanged(widget.quantity - 1))
                      : null,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: ConstantsColor.colorMain.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              // Quantity Display
              SizedBox(
                width: 28,
                height: 32,
                child: Center(
                  child: Text(
                    '${widget.quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              // Plus Button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _onButtonPressed(() => widget.onQuantityChanged(widget.quantity + 1)),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: ConstantsColor.colorMain,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: ConstantsColor.colorMain.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add, size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
