import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:techbox/src/core/theme/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> images;

  const ProductImageCarousel({super.key, required this.images});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final _pageController = PageController();
  final _thumbnailController = ScrollController();
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged:
                (index) => setState(() => _currentImageIndex = index),
            itemBuilder: (_, index) => Image.network(widget.images[index]),
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.images.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColors.primary,
            dotColor: Colors.grey.shade300,
          ),
        ),
        const SizedBox(height: 24),

        SizedBox(
          height: 60,
          child: ListView.builder(
            controller: _thumbnailController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final isSelected = _currentImageIndex == index;
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          isSelected ? AppColors.primary : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Image.network(widget.images[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
