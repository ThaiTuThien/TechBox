import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';

const Map<String, Color> colorOptions = {
  'Starlight': Color(0xFFF0EAE0),
  'Green': Color(0xFF3B4A3F),
  'Black': Colors.black,
  'Purple': Colors.purple,
};

class ProductVariantSection extends StatefulWidget {
  const ProductVariantSection({super.key});

  @override
  State<ProductVariantSection> createState() => _ProductVariantSectionState();
}

class _ProductVariantSectionState extends State<ProductVariantSection> {
  final List<String> _capacities = ['64GB', '128GB', '256GB', '512GB'];
  String _selectedCapacity = '64GB';

  final List<String> _colorNames = colorOptions.keys.toList();
  final List<Color> _colors = colorOptions.values.toList();
  String _selectedColorName = 'Green';

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Dung lượng"),
        Wrap(
          spacing: 12.0,
          runSpacing: 10.0,
          children:
              _capacities.map((capacity) {
                final bool isSelected = _selectedCapacity == capacity;
                return ChoiceChip(
                  label: Text(capacity),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCapacity = capacity;
                      });
                    }
                  },
                  showCheckmark: false,
                  selectedColor: Colors.white,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade600,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  side: BorderSide(
                    color:
                        isSelected ? AppColors.primary : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 11.5,
                  ),
                );
              }).toList(),
        ),

        const SizedBox(height: 24),
        _buildSectionTitle("Màu sắc: $_selectedColorName"),
        Wrap(
          spacing: 16.0,
          runSpacing: 10.0,
          children: List.generate(_colors.length, (index) {
            final color = _colors[index];
            final colorName = _colorNames[index];
            final isSelected = _selectedColorName == colorName;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorName = colorName;
                });
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    isSelected ? AppColors.primary : Colors.transparent,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(radius: 15, backgroundColor: color),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
