import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/common_widgets/success_notification.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/payment/presentation/widgets/store_info.dart';
import 'package:techbox/src/features/payment/presentation/widgets/product_item.dart';
import 'package:techbox/src/features/payment/presentation/widgets/shipping_method_item.dart';
import 'package:techbox/src/features/payment/presentation/widgets/payment_method_item.dart';
import 'package:techbox/src/features/payment/presentation/widgets/discount_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/order_summary.dart';
import 'package:techbox/src/features/payment/presentation/widgets/bottom_button.dart';
import 'package:techbox/src/features/payment/presentation/widgets/product_item.dart' show mockImageUrl;

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
                    StoreInfo(
                      storeName: 'Dương Nguyễn Thuận Thiên',
                      storeAddress: '111 Đường 3/2, Phường 12, Quận 10, TP.HCM',
                      onEditPressed: () {},
                    ),
                    _divider(),

                    // Product List
                    _buildSectionTitle(title: 'Danh sách đơn hàng'),
                    const SizedBox(height: 12),
                    ProductItem(
                      productName: 'iPhone 14 Pro Max 256GB',
                      productColor: 'Navy',
                      colorValue: const Color(0xFF1E3A8A),
                      price: 12000000,
                      quantity: 1,
                      imageUrl: mockImageUrl,
                    ),
                    _divider(),
                    ProductItem(
                      productName: 'iPhone 14 Pro Max 256GB',
                      productColor: 'Navy',
                      colorValue: Colors.orange,
                      price: 12000000,
                      quantity: 2,
                      imageUrl: mockImageUrl,
                    ),
                    _divider(),
                    ProductItem(
                      productName: 'iPhone 14 Pro Max 256GB',
                      productColor: 'Navy',
                      colorValue: Colors.red,
                      price: 12000000,
                      quantity: 3,
                      imageUrl: mockImageUrl,
                    ),
                    _divider(),

                    // Shipping Methods
                    _buildSectionTitle(title: 'Phương thức vận chuyển'),
                    const SizedBox(height: 12),
                    ShippingMethodItem(
                      index: 0,
                      methodName: 'Tiêu chuẩn',
                      description: 'Ngày nhận dự kiến: 27-30 tháng 7',
                      price: 15000,
                      color: const Color.fromARGB(90, 9, 162, 134),
                      containerBorderColor: const Color.fromARGB(
                        255,
                        9,
                        162,
                        133,
                      ),
                      icon: Icons.local_shipping,
                      isSelected: selectedShippingMethod == 0,
                      onTap: () => setState(() => selectedShippingMethod = 0),
                    ),
                    ShippingMethodItem(
                      index: 1,
                      methodName: 'Nhanh',
                      description: 'Ngày nhận dự kiến: 25-26 tháng 7',
                      price: 25000,
                      color: const Color.fromARGB(90, 220, 123, 7),
                      containerBorderColor: const Color.fromARGB(
                        255,
                        220,
                        123,
                        7,
                      ),
                      icon: Icons.flash_on,
                      isSelected: selectedShippingMethod == 1,
                      onTap: () => setState(() => selectedShippingMethod = 1),
                    ),
                    ShippingMethodItem(
                      index: 2,
                      methodName: 'Hỏa tốc',
                      description: 'Giao hàng 4 giờ tới',
                      price: 40000,
                      color: const Color.fromARGB(90, 229, 51, 51),
                      containerBorderColor: const Color.fromARGB(
                        255,
                        229,
                        51,
                        51,
                      ),
                      icon: Icons.rocket_launch,
                      isSelected: selectedShippingMethod == 2,
                      onTap: () => setState(() => selectedShippingMethod = 2),
                    ),
                    _divider(),

                    // Payment Methods
                    _buildSectionTitle(title: 'Phương thức thanh toán'),
                    const SizedBox(height: 12),
                    PaymentMethodItem(
                      methodName: 'Thanh toán với Stripe',
                      iconAssetPath: 'assets/image/stripe.png',
                      color: const Color.fromARGB(90, 99, 91, 255),
                      containerBorderColor: const Color.fromARGB(
                        255,
                        99,
                        91,
                        255,
                      ),
                      isSelected: selectedPaymentMethod == 0,
                      onTap: () => setState(() => selectedPaymentMethod = 0),
                    ),
                    PaymentMethodItem(
                      methodName: 'Thanh toán với MoMo',
                      iconAssetPath: 'assets/image/momo.png',
                      color: const Color.fromARGB(90, 165, 0, 100),
                      containerBorderColor: const Color.fromARGB(
                        255,
                        165,
                        0,
                        100,
                      ),
                      isSelected: selectedPaymentMethod == 1,
                      onTap: () => setState(() => selectedPaymentMethod = 1),
                    ),
                    PaymentMethodItem(
                      methodName: 'Thanh toán khi nhận hàng',
                      iconAssetPath: 'assets/image/cash_on_delivery.png',
                      color: const Color.fromARGB(90, 16, 185, 129),
                      containerBorderColor: const Color.fromARGB(
                        255,
                        16,
                        185,
                        129,
                      ),
                      isSelected: selectedPaymentMethod == 2,
                      onTap: () => setState(() => selectedPaymentMethod = 2),
                    ),
                    _divider(),

                    // Discount Code
                    DiscountSection(
                      controller: _discountController,
                      onAddPressed: () {},
                    ),
                    _divider(),

                    // Order Summary
                    OrderSummary(
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
      bottomNavigationBar: BottomButton(
        buttonText: 'Đặt hàng',
        onPressed: () {
          SuccessNotification.show(
            context,
            subtitleText: 'Chúc mừng bạn đã thanh toán thành công',
            buttonText: 'OK',
          );
        },
      ),
    );
  }

  // Address Info

  Widget _buildSectionTitle({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: ConstantsColor.colorMain,
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        color: const Color.fromARGB(255, 230, 230, 230),
        height: 1,
      ),
    );
  }

  @override
  void dispose() {
    _discountController.dispose();
    super.dispose();
  }
}
