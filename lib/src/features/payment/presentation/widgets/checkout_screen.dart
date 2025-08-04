import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/common_widgets/success_notification.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/address/presentation/update_address/update_address.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedShippingMethod = 0;
  int selectedPaymentMethod = 0;
  final TextEditingController _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: 'Thanh toán',
        showBackButton: true,
        showBottomBorder: false,
        onBackPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(title: 'Thông tin giao hàng'),
                    const SizedBox(height: 8),
                    // Store Info
                    _buildStoreInfo(
                      storeName: 'Dương Nguyễn Thuận Thiên',
                      storeAddress: '111 Đường 3/2, Phường 12, Quận 10, TP.HCM',
                      onEditPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute (
                            builder: (context) => UpdateAddressPage()
                          ),
                        );
                      },
                    ),
                    _divider(),
            
                    // Product List
                    _buildSectionTitle(title: 'Danh sách đơn hàng'),
                    const SizedBox(height: 12),
                    _buildProductItem(
                      productName: 'iPhone 14 Pro Max 256GB',
                      productColor: 'Navy',
                      colorValue: const Color(0xFF1E3A8A), 
                      price: 12000000,
                      quantity: 1,
                    ),
                    _divider(),
                    _buildProductItem(
                      productName: 'iPhone 14 Pro Max 256GB',
                      productColor: 'Navy',
                      colorValue: Colors.orange,
                      price: 12000000,
                      quantity: 2,
                    ),
                    _divider(),
                    _buildProductItem(
                      productName: 'iPhone 14 Pro Max 256GB',
                      productColor: 'Navy',
                      colorValue: Colors.red,
                      price: 12000000,
                      quantity: 3,
                    ),
                    _divider(),
                    
                    // Shipping Methods
                    _buildSectionTitle(title: 'Phương thức vận chuyển'),
                    const SizedBox(height: 12),
                    _buildShippingMethodItem(
                      index: 0,
                      methodName: 'Tiêu chuẩn',
                      description: 'Ngày nhận dự kiến: 27-30 tháng 7',
                      price: 15000,
                      color: const Color.fromARGB(90, 9, 162, 134),
                      containerBorderColor: const Color.fromARGB(255, 9, 162, 133),
                      icon: Icons.local_shipping,
                      isSelected: selectedShippingMethod == 0,
                      onTap: () => setState(() => selectedShippingMethod = 0),
                    ),
                    _buildShippingMethodItem(
                      index: 1,
                      methodName: 'Nhanh',
                      description: 'Ngày nhận dự kiến: 25-26 tháng 7',
                      price: 25000,
                      color: const Color.fromARGB(90, 220, 123, 7),
                      containerBorderColor: const Color.fromARGB(255, 220, 123, 7),
                      icon: Icons.flash_on,
                      isSelected: selectedShippingMethod == 1,
                      onTap: () => setState(() => selectedShippingMethod = 1),
                    ),
                    _buildShippingMethodItem(
                      index: 2,
                      methodName: 'Hỏa tốc',
                      description: 'Giao hàng 4 giờ tới',
                      price: 40000,
                      color: const Color.fromARGB(90, 229, 51, 51),
                      containerBorderColor: const Color.fromARGB(255, 229, 51, 51),
                      icon: Icons.rocket_launch,
                      isSelected: selectedShippingMethod == 2,
                      onTap: () => setState(() => selectedShippingMethod = 2),
                    ),
                    _divider(),
                    
                    // Payment Methods
                    _buildSectionTitle(title: 'Phương thức thanh toán'),
                    const SizedBox(height: 12),
                    _buildPaymentMethodItem(
                      methodName: 'Thanh toán với Stripe',
                      iconAssetPath: 'assets/image/stripe.png',
                      color: const Color.fromARGB(90, 99, 91, 255),
                      containerBorderColor: const Color.fromARGB(255, 99, 91, 255),
                      isSelected: selectedPaymentMethod == 0,
                      onTap: () => setState(() => selectedPaymentMethod = 0),
                    ),
                    _buildPaymentMethodItem(
                      methodName: 'Thanh toán với MoMo',
                      iconAssetPath: 'assets/image/momo.png',
                      color: const Color.fromARGB(90, 165, 0, 100),
                      containerBorderColor: const Color.fromARGB(255, 165, 0, 100),
                      isSelected: selectedPaymentMethod == 1,
                      onTap: () => setState(() => selectedPaymentMethod = 1),
                    ),
                    _buildPaymentMethodItem(
                      methodName: 'Thanh toán khi nhận hàng',
                      iconAssetPath: 'assets/image/cash_on_delivery.png',
                      color: const Color.fromARGB(90, 16, 185, 129),
                      containerBorderColor: const Color.fromARGB(255, 16, 185, 129),
                      isSelected: selectedPaymentMethod == 2,
                      onTap: () => setState(() => selectedPaymentMethod = 2),
                    ),
                    _divider(),
                    
                    // Discount Code
                    _buildDiscountSection(
                      controller: _discountController,
                      onAddPressed: () {},
                    ),
                    _divider(),
                    
                    // Order Summary
                    _buildOrderSummary(
                      subtotal: 96000000,
                      shippingFee: 25000,
                      discount: 12800,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(
        buttonText: 'Đặt hàng',
        onPressed: () {
          SuccessNotification.show(
            context, 
            subtitleText: 'Chúc mừng bạn đã thanh toán thành công', 
            buttonText: 'OK'
          );
        },
      ),
    );
  }

  // Address Info
  Widget _buildStoreInfo({
  required String storeName,
  required String storeAddress,
  required VoidCallback onEditPressed,
}) {
  return _buildWhiteContainer(
    hasShadow: true,
    borderColor: const Color.fromARGB(255, 230, 230, 230),
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
              Text(
                storeAddress,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
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

  Widget _buildProductItem({
  required String productName,
  required String productColor,
  required Color colorValue,
  required int price,
  required int quantity,
}) {
  return _buildWhiteContainer(
    margin: const EdgeInsets.only(bottom: 8),
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
        
        // Product Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              
              // Color Row with circle
              Row(
                children: [
                  const Text(
                    'Màu : ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
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
              
              // Price and Quantity Row - UPDATED
              Row(
                children: [
                  // Price
                  Text(
                    '${_formatPrice(price)}đ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(width: 90), 
                  
                  // Quantity in Circle
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
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
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // Shipping Method Item Widget
  Widget _buildShippingMethodItem({
  required int index,
  required String methodName,
  required String description,
  required int price,
  required Color color,
  required Color containerBorderColor,
  required IconData icon,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return _buildWhiteContainer(
    margin: const EdgeInsets.only(bottom: 12),
    borderColor: isSelected ? containerBorderColor : color,
    borderWidth: 2.0,
    hasShadow: false,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(0), 
        child: Row(
          children: [
            // Icon Container
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
            
            // Content
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price > 0 ? '${_formatPrice(price)}đ' : '15.000đ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: price > 0 ? Colors.black87 : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            
            // Radio Button với hình tròn nhỏ bên trong
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
              child: isSelected
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
    ),
  );
}

  // Payment Method Item Widget
  Widget _buildPaymentMethodItem({
  required String methodName,
  required String iconAssetPath, 
  required Color color,
  required Color containerBorderColor, 
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return _buildWhiteContainer(
    margin: const EdgeInsets.only(bottom: 12),
    borderColor: isSelected ? containerBorderColor : color, 
    borderWidth: 2.0,
    hasShadow: false,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            // Icon Container với Image.asset
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Image.asset(
                  iconAssetPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            Expanded(
              child: Text(
                methodName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? containerBorderColor : Colors.black87,
                ),
              ),
            ),
            
            // Radio Button 
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
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? containerBorderColor : color, 
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    ),
  );
}

  // Discount Section Widget
  Widget _buildDiscountSection({
  required TextEditingController controller,
  required VoidCallback onAddPressed,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Thẻ giảm giá',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          // Input field
          Expanded(
            child: Container(
              height: 52,
              width: 262,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color.fromARGB(255, 230, 230, 230), width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.local_offer_outlined, color: Colors.grey),
                  const SizedBox(width: 12),
                  Padding(padding: const EdgeInsets.only(left: 8)), 
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Nhập mã giảm giá',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 8), 
          
          // Add button
          GestureDetector(
            onTap: onAddPressed,
            child: Container(
              height: 52,
              width: 88,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: ConstantsColor.colorMain,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Thêm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

  // Order Summary Widget
  Widget _buildOrderSummary({
    required int subtotal,
    required int shippingFee,
    required int discount,
  }) {
    int total = subtotal + shippingFee - discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: 'Chi tiết thanh toán'),
        const SizedBox(height: 12),
        _buildWhiteContainer(
          hasShadow: false,
          child: Column(
            children: [
              _buildSummaryRow(
                label: 'Tổng tiền hàng',
                value: '${_formatPrice(subtotal)}đ',
                color: const Color.fromARGB(225, 128, 128, 128),
              ),
              _buildSummaryRow(
                label: 'Phí vận chuyển',
                value: '${_formatPrice(shippingFee)}đ',
                color: const Color.fromARGB(225, 128, 128, 128),
              ),
              _buildSummaryRow(
                label: 'Giảm giá',
                value: '-${_formatPrice(discount)}đ',
                color: const Color.fromARGB(255, 16, 185, 129),
                isDiscount: true,
              ),
              const Divider(),
              _buildSummaryRow(
                label: 'Tổng thanh toán',
                value: '${_formatPrice(total)}đ',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Summary Row Widget
  Widget _buildSummaryRow({
    required String label,
    required String value,
    Color? color,
    bool isTotal = false,  bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 20 : 16,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
              color: color ?? ConstantsColor.colorMain,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: color ?? (isDiscount ? const Color.fromARGB(255, 16, 185, 129) : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ConstantsColor.colorMain,
      ),
    );
  }

  Widget _divider(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        color: const Color.fromARGB(255, 230, 230, 230),
        height: 1,
      ),
    );
  }

  // White Container Widget
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
          ? Border.all(
              color: borderColor,
              width: borderWidth,
            )
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

  // Bottom Button Widget
  Widget _buildBottomButton({
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: 341,
          height: 54,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ConstantsColor.colorMain,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper Functions
  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }
}