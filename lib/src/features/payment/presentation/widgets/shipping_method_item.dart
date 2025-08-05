import 'package:flutter/material.dart';
import 'package:techbox/src/utils/currency_formatted.dart';

class ShippingMethodItem extends StatelessWidget {
  final int index;
  final String methodName;
  final String description;
  final int price;
  final Color color;
  final Color containerBorderColor;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  const ShippingMethodItem({
    Key? key,
    required this.index,
    required this.methodName,
    required this.description,
    required this.price,
    required this.color,
    required this.containerBorderColor,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? containerBorderColor : color,
          width: 2.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? containerBorderColor : color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    methodName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? containerBorderColor : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price > 0 ? '${formatCurrency(price)}' : '15.000đ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: price > 0 ? Colors.black87 : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? containerBorderColor : color,
                  width: 2,
                ),
                color: Colors.white,
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: containerBorderColor,
                          ),
                        ),
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
