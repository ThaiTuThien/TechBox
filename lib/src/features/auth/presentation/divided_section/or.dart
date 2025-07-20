import 'package:flutter/material.dart';

class OrComponent extends StatelessWidget {
  const OrComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1, color: Colors.grey.shade400)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('Hoặc', style: TextStyle(color: Colors.grey.shade600))
          ),
          Expanded(child: Divider(thickness: 1, color: Colors.grey.shade400))
        ],
      ),
    );
  }
}