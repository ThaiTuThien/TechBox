import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/payment/presentation/widgets/checkout_screen.dart';
import 'package:techbox/src/features/cart/presentation/widgets/cart_empty.dart'; 

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int product1Quantity = 1;
  int product2Quantity = 1;
  int product3Quantity = 1;

  // Prices
  final int productPrice = 12000000;

  @override
  Widget build(BuildContext context) {
    // Tính tổng tiền
    int totalPrice =
        (product1Quantity + product2Quantity + product3Quantity) * productPrice;

    // Kiểm tra nếu không có sản phẩm (tổng số lượng = 0)
    bool isCartEmpty = product1Quantity == 0 && product2Quantity == 0 && product3Quantity == 0;

    return isCartEmpty
        ? CartEmpty() 
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarComponent(
              title: 'Giỏ Hàng',
              showBackButton: true,
              showBottomBorder: false,
              onBackPressed: () => Navigator.pop(context),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          _buildProductItem(
                            productName: 'iPhone 14 Pro Max 256GB',
                            productColor: 'Navy',
                            colorValue: const Color(0xFF1E3A8A),
                            price: productPrice,
                            quantity: product1Quantity,
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                product1Quantity = newQuantity;
                              });
                            },
                            onDelete: () {
                              setState(() {
                                product1Quantity = 0;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã xóa sản phẩm Navy')),
                              );
                            },
                          ),
                          _divider(),
                          _buildProductItem(
                            productName: 'iPhone 14 Pro Max 256GB',
                            productColor: 'Black',
                            colorValue: Colors.black,
                            price: productPrice,
                            quantity: product2Quantity,
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                product2Quantity = newQuantity;
                              });
                            },
                            onDelete: () {
                              setState(() {
                                product2Quantity = 0;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã xóa sản phẩm Black')),
                              );
                            },
                          ),
                          _divider(),
                          _buildProductItem(
                            productName: 'iPhone 14 Pro Max 256GB',
                            productColor: 'Navy',
                            colorValue: const Color(0xFF1E3A8A),
                            price: productPrice,
                            quantity: product3Quantity,
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                product3Quantity = newQuantity;
                              });
                            },
                            onDelete: () {
                              setState(() {
                                product3Quantity = 0;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Đã xóa sản phẩm Navy thứ 2')),
                              );
                            },
                          ),
                          _divider(),
                          const SizedBox(height: 95),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomSection(totalPrice: totalPrice),
                ],
              ),
            ),
          );
  }

  Widget _buildBottomSection({required int totalPrice}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 27),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Tổng tiền',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_formatPrice(totalPrice)}đ',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantsColor.colorMain,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/checkpayment.png',
                          width: 17,
                          height: 17,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.payment,
                              size: 17,
                              color: Colors.white,
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Thanh toán',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

  Widget _buildQuantityControls({
    required int quantity,
    required Function(int) onQuantityChanged,
  }) {
    return Row(
      children: [
        // Minus Button
        GestureDetector(
          onTap: () {
            if (quantity > 1) {
              onQuantityChanged(quantity - 1);
            }
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: quantity > 1 ? ConstantsColor.colorMain : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.remove,
              size: 12,
              color: quantity > 1 ? Colors.white : Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Quantity Display
        Container(
          width: 40,
          height: 32,
          child: Center(
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Plus Button
        GestureDetector(
          onTap: () {
            onQuantityChanged(quantity + 1);
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ConstantsColor.colorMain,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, size: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildWhiteContainer({
    required Widget child,
    EdgeInsetsGeometry? margin,
    Color backgroundColor = Colors.white,
    Color? borderColor,
    double borderWidth = 1.0,
    bool hasShadow = true,
    Color? shadowColor,
    double shadowOpacity = 0.1,
    double shadowSpreadRadius = 1,
    double shadowBlurRadius = 4,
    Offset shadowOffset = const Offset(0, 2),
    double borderRadius = 12,
  }) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: (shadowColor ?? Colors.grey).withOpacity(shadowOpacity),
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

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 1, color: Color.fromARGB(255, 230, 230, 230)),
    );
  }

  Widget _buildProductItem({
    required String productName,
    required String productColor,
    required Color colorValue,
    required int price,
    required int quantity,
    required Function(int) onQuantityChanged,
    VoidCallback? onDelete,
  }) {
    Widget productItem = _buildWhiteContainer(
      hasShadow: false,
      child: Row(
        children: [
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.phone_iphone, size: 40, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ConstantsColor.colorMain,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Màu : ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: colorValue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      productColor,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${_formatPrice(price)}đ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    _buildQuantityControls(
                      quantity: quantity,
                      onQuantityChanged: onQuantityChanged,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (onDelete != null) {
      return Dismissible(
        key: Key(
          '${productName}_${productColor}_${DateTime.now().millisecondsSinceEpoch}',
        ),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 33),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.delete,
            color: Color.fromARGB(255, 231, 71, 81),
            size: 32,
          ),
        ),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Xác nhận xóa'),
                content: const Text('Bạn có chắc chắn muốn xóa sản phẩm này?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'Xóa',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) => onDelete(),
        child: productItem,
      );
    }

    return productItem;
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}