import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/product/domain/models/product_variant_model.dart';
import 'package:techbox/src/utils/color_formatted.dart';

class ProductVariantSection extends StatefulWidget {
  final List<ProductVariantModel> variants;
  final ProductVariantModel currentVariant;
  final ValueChanged<ProductVariantModel> onVariantSelected;

  const ProductVariantSection({
    super.key,
    required this.variants,
    required this.currentVariant,
    required this.onVariantSelected,
  });

  @override
  State<ProductVariantSection> createState() => _ProductVariantSectionState();
}

class _ProductVariantSectionState extends State<ProductVariantSection> {
  late List<String> _uniqueStorages;
  late List<ColorModel> _uniqueColors;

  @override
  void initState() {
    super.initState();
    _processVariants();
  }

  @override
  void didUpdateWidget(covariant ProductVariantSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.variants != oldWidget.variants) {
      _processVariants();
    }
  }

  void _processVariants() {
    _uniqueStorages = widget.variants.map((v) => v.storage).toSet().toList();

    final colorMap = <String, ColorModel>{};
    for (var variant in widget.variants) {
      colorMap[variant.color.colorName] = variant.color;
    }
    _uniqueColors = colorMap.values.toList();
  }

  void _onSelectionChanged(String? newStorage, String? newColorName) {
    final selectedStorage = newStorage ?? widget.currentVariant.storage;
    final selectedColorName =
        newColorName ?? widget.currentVariant.color.colorName;

    try {
      final newVariant = widget.variants.firstWhere(
        (v) =>
            v.storage == selectedStorage &&
            v.color.colorName == selectedColorName,
      );
      widget.onVariantSelected(newVariant);
    } catch (e) {
      print("Không tìm thấy biến thể cho sự kết hợp này.");
    }
  }

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
              _uniqueStorages.map((capacity) {
                final bool isSelected =
                    widget.currentVariant.storage == capacity;
                return ChoiceChip(
                  label: Text(capacity),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      _onSelectionChanged(capacity, null);
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
        _buildSectionTitle("Màu sắc: ${widget.currentVariant.color.colorName}"),
        Wrap(
          spacing: 16.0,
          runSpacing: 10.0,
          //...
          children:
              _uniqueColors.map((colorModel) {
                final isSelected =
                    widget.currentVariant.color.colorName ==
                    colorModel.colorName;
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        // Độ lan của bóng
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _onSelectionChanged(null, colorModel.colorName);
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          isSelected ? AppColors.primary : Colors.transparent,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: colorFromHex(colorModel.colorCode),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
          //...toList(),
        ),
      ],
    );
  }
}
