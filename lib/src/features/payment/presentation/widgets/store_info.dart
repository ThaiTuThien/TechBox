import 'package:flutter/material.dart';
import 'package:techbox/src/core/constants.dart';

class StoreInfo extends StatelessWidget {
  final String storeName;
  final String storeAddress;
  final VoidCallback onEditPressed;
  const StoreInfo({
    Key? key,
    required this.storeName,
    required this.storeAddress,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 230, 230, 230),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ConstantsColor.colorMain,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: const Color.fromARGB(255, 230, 230, 230),
                width: 5,
              ),
            ),
            child: Image.asset(
              'assets/image/address.png',
              width: 16,
              height: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  storeName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text(
                    storeAddress,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onEditPressed,
            child: Image.asset(
              'assets/image/edit.png',
              width: 17,
              height: 17,
            ),
          ),
        ],
      ),
    );
    }
} 