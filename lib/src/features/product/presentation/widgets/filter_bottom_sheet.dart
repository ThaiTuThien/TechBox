import 'package:flutter/material.dart';
import 'package:techbox/src/core/theme/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(200000, 2000000);
  String _selectedCategory = 'iPhone';
  int _selectedColor = 0;
  int _selectedRating = 5;

  final List<String> _categories = ['iPhone', 'iPad', 'MacBook'];
  final List<String> _capacities = ['128GB', '256GB', '512GB'];
  String _selectedCapacity = '256GB';
  final List<Color> _colors = [
    Colors.brown,
    Colors.cyan,
    Colors.red,
    Colors.lightGreen,
  ];

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Divider(color: Colors.grey.shade200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bộ lọc',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionTitle('Danh mục'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  _categories.map((cat) {
                    final bool selected = _selectedCategory == cat;
                    return ChoiceChip(
                      label: Text(cat),
                      selected: selected,
                      onSelected:
                          (_) => setState(() => _selectedCategory = cat),
                      showCheckmark: false,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color:
                            selected ? AppColors.primary : Colors.grey.shade300,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  }).toList(),
            ),
            _buildDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('Giá'),
                Text(
                  '${_priceRange.start.toInt()} - ${_priceRange.end.toInt()}đ',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 5000000,
              labels: null,
              onChanged: (values) => setState(() => _priceRange = values),
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey.shade200,
            ),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSectionTitle('Dung lượng'),
                DropdownButton<String>(
                  value: _selectedCapacity,
                  items:
                      _capacities
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCapacity = val);
                  },
                  underline: Container(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            _buildDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSectionTitle('Đánh giá'),
                DropdownButton<int>(
                  value: _selectedRating,
                  items:
                      List.generate(5, (index) {
                        int rating = 5 - index;
                        return DropdownMenuItem(
                          value: rating,
                          child: Row(
                            children: [
                              Text('$rating '),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedRating = val);
                  },
                  underline: Container(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            _buildDivider(),
            _buildSectionTitle('Màu sắc'),
            Wrap(
              spacing: 12.0,
              children: List.generate(
                _colors.length,
                (i) => GestureDetector(
                  onTap: () => setState(() => _selectedColor = i),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: _colors[i],
                      child:
                          _selectedColor == i
                              ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              )
                              : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
