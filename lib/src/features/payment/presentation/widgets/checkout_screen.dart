import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/common_widgets/success_notification.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';
import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';
import 'package:techbox/src/features/cart/application/cart_services.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'package:techbox/src/features/shipping/domain/Models/shipping_method.dart';
import 'package:techbox/src/features/shipping/presentation/Controller/shipping_method_controller.dart';
import 'package:techbox/src/features/shipping/presentation/State/shipping_method_state.dart';
import 'package:techbox/src/features/payment/presentation/widgets/store_info.dart';
import 'package:techbox/src/features/payment/presentation/widgets/product_item.dart';
import 'package:techbox/src/features/payment/presentation/widgets/shipping_method_item.dart';
import 'package:techbox/src/features/payment/presentation/widgets/payment_method_item.dart';
import 'package:techbox/src/features/payment/presentation/widgets/discount_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/order_summary.dart';
import 'package:techbox/src/features/payment/presentation/widgets/bottom_button.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final List<CartItem> cartItems;
  final int totalPrice;

  const CheckoutPage({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  int selectedShippingMethod = 0;
  int selectedPaymentMethod = 0;
  final TextEditingController _discountController = TextEditingController();
  List<ShippingMethod> shippingMethods = [];
  bool isShippingLoading = false;
  String? shippingError;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _refreshProfile();
      }
    });
  }

  void _refreshProfile() {
    try {
      final controller = ref.read(profileControllerProvider.notifier);
      controller.fetchProfile();
    } catch (e) {
      debugPrint('Error fetching profile: $e');
    }
  }

  Future<void> _calculateShippingFee() async {
    try {
      setState(() {
        isShippingLoading = true;
        shippingError = null;
      });

      final profileState = ref.read(profileControllerProvider);
      if (profileState is ProfileSuccess) {
        final address = profileState.response.address;
        final shippingAddress = _formatAddress(address);

        final dto = CalculateFeeDto(
          shippingAddress: shippingAddress,
          weight: _calculateTotalWeight(),
          height: 10,
          length: 20,
          width: 15,
          insuranceValue: widget.totalPrice,
        );

        await ref
            .read(shippingMethodControllerProvider.notifier)
            .calculateFee(dto);
      }
    } catch (e) {
      setState(() {
        shippingError = 'Không thể tính cước phí vận chuyển: $e';
      });
    } finally {
      setState(() {
        isShippingLoading = false;
      });
    }
  }

  int _calculateTotalWeight() {
    return widget.cartItems.fold(
      0,
      (total, item) => total + (item.quantity * 500),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
                    Consumer(
                      builder: (context, ref, child) {
                        final profileState = ref.watch(
                          profileControllerProvider,
                        );
                        return _buildStoreInfo(profileState, ref);
                      },
                    ),
                    _divider(),
                    _buildSectionTitle(title: 'Danh sách đơn hàng'),
                    const SizedBox(height: 12),
                    if (widget.cartItems.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Giỏ hàng trống',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      ...widget.cartItems.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Column(
                          children: [
                            ProductItem(
                              productName:
                                  item.productName + " " + item.storage,
                              productColor: item.colorName,
                              colorValue: _parseColor(item.colorCode),
                              price: item.price,
                              quantity: item.quantity,
                              imageUrl: item.imageUrl,
                            ),
                            if (index < widget.cartItems.length - 1) _divider(),
                          ],
                        );
                      }).toList(),
                    _divider(),

                    _buildSectionTitle(title: 'Phương thức vận chuyển'),
                    const SizedBox(height: 12),
                    Consumer(
                      builder: (context, ref, child) {
                        final profileState = ref.watch(
                          profileControllerProvider,
                        );
                        final shippingState = ref.watch(
                          shippingMethodControllerProvider,
                        );

                        if (profileState is ProfileSuccess &&
                            shippingMethods.isEmpty &&
                            !isShippingLoading) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _calculateShippingFee();
                          });
                        }

                        // Cập nhật shipping methods từ API response
                        if (shippingState is ShippingMethodSuccess &&
                            shippingMethods.isEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              shippingMethods =
                                  shippingState.response.data.methods;
                              selectedShippingMethod = 0;
                            });
                          });
                        }

                        if (isShippingLoading) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text('Đang tính cước phí vận chuyển...'),
                              ],
                            ),
                          );
                        }

                        if (shippingError != null) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red.shade700,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Lỗi tính cước phí',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  shippingError!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red.shade600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: _calculateShippingFee,
                                    icon: const Icon(Icons.refresh, size: 16),
                                    label: const Text('Thử lại'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.shade50,
                                      foregroundColor: Colors.red.shade700,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (shippingMethods.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Vui lòng cập nhật địa chỉ để tính cước phí vận chuyển',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        return Column(
                          children:
                              shippingMethods.asMap().entries.map((entry) {
                                final index = entry.key;
                                final method = entry.value;
                                final isHCM = _isHoChiMinhCity();

                                if (method.type == 'super-express' && !isHCM) {
                                  return const SizedBox.shrink();
                                }

                                return Column(
                                  children: [
                                    ShippingMethodItem(
                                      index: index,
                                      methodName: method.name,
                                      description: _getShippingDescription(
                                        method.type,
                                      ),
                                      price: method.fee,
                                      color: _getShippingColor(method.type),
                                      containerBorderColor:
                                          _getShippingBorderColor(method.type),
                                      icon: _getShippingIcon(method.type),
                                      isSelected:
                                          selectedShippingMethod == index,
                                      onTap:
                                          () => setState(
                                            () =>
                                                selectedShippingMethod = index,
                                          ),
                                    ),
                                    if (index < shippingMethods.length - 1)
                                      const SizedBox(height: 4),
                                  ],
                                );
                              }).toList(),
                        );
                      },
                    ),
                    _divider(),

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
                    Consumer(
                      builder: (context, ref, child) {
                        return OrderSummary(
                          subtotal: widget.totalPrice,
                          shippingFee: _getShippingFee(),
                          discount: 12800,
                        );
                      },
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
        onPressed: () async {
          try {
            await ref.read(cartServiceProvider).clearCart();

            SuccessNotification.show(
              context,
              subtitleText: 'Chúc mừng bạn đã thanh toán thành công',
              buttonText: 'OK',
            );

            Navigator.pop(context);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Có lỗi xảy ra: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStoreInfo(ProfileState profileState, WidgetRef ref) {
    return switch (profileState) {
      ProfileLoading() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đang tải thông tin...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vui lòng chờ trong giây lát',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      ProfileError(:final message) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Không thể tải thông tin địa chỉ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(profileControllerProvider.notifier).fetchProfile();
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Thử lại'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red.shade700,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
        ),
      ),

      ProfileSuccess(:final response) => StoreInfo(
        storeName: response.name.isNotEmpty ? response.name : 'Chưa có tên',
        storeAddress: _formatAddress(response.address),
        onEditPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditScreen()));
        },
      ),

      ProfileInitial() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.person_outline, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đang tải thông tin...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vui lòng chờ trong giây lát',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    };
  }

  String _formatAddress(Address address) {
    final parts = <String>[];

    if (address.street.isNotEmpty) parts.add(address.street);
    if (address.ward.isNotEmpty) parts.add(address.ward);
    if (address.district.isNotEmpty) parts.add(address.district);
    if (address.city.isNotEmpty) parts.add(address.city);
    if (address.country.isNotEmpty) parts.add(address.country);

    if (parts.isEmpty) {
      return 'Chưa có địa chỉ giao hàng';
    }

    final formattedParts = <String>[];

    if (address.street.isNotEmpty) {
      formattedParts.add(address.street);
    }

    if (address.ward.isNotEmpty) {
      formattedParts.add('${address.ward}');
    }

    if (address.district.isNotEmpty) {
      formattedParts.add('${address.district}');
    }

    if (address.city.isNotEmpty) {
      formattedParts.add(address.city);
    }

    if (address.country.isNotEmpty && address.country != 'Vietnam') {
      formattedParts.add(address.country);
    }

    return formattedParts.join(', ');
  }

  Color _parseColor(String colorCode) {
    try {
      // Remove # if present
      String hex = colorCode.replaceAll('#', '');

      // Handle different hex formats
      if (hex.length == 6) {
        hex = 'FF$hex'; // Add alpha channel
      }

      // Parse hex to int
      int colorInt = int.parse(hex, radix: 16);
      return Color(colorInt);
    } catch (e) {
      // Return default color if parsing fails
      return Colors.grey;
    }
  }

  int _getShippingFee() {
    if (shippingMethods.isEmpty ||
        selectedShippingMethod >= shippingMethods.length) {
      return 0;
    }
    return shippingMethods[selectedShippingMethod].fee;
  }

  bool _isHoChiMinhCity() {
    final profileState = ref.read(profileControllerProvider);
    if (profileState is ProfileSuccess) {
      final city = profileState.response.address.city.toLowerCase();
      return city.contains('hồ chí minh') ||
          city.contains('ho chi minh') ||
          city.contains('tp.hcm');
    }
    return false;
  }

  String _getShippingDescription(String type) {
    switch (type) {
      case 'standard':
        return 'Ngày nhận dự kiến: 3-5 ngày làm việc';
      case 'express':
        return 'Ngày nhận dự kiến: 1-2 ngày làm việc';
      case 'super-express':
        return 'Giao hàng 4 giờ tới (chỉ TP.HCM)';
      default:
        return 'Thời gian giao hàng theo đơn vị vận chuyển';
    }
  }

  Color _getShippingColor(String type) {
    switch (type) {
      case 'standard':
        return const Color.fromARGB(90, 9, 162, 134);
      case 'express':
        return const Color.fromARGB(90, 220, 123, 7);
      case 'super-express':
        return const Color.fromARGB(90, 229, 51, 51);
      default:
        return const Color.fromARGB(90, 128, 128, 128);
    }
  }

  Color _getShippingBorderColor(String type) {
    switch (type) {
      case 'standard':
        return const Color.fromARGB(255, 9, 162, 133);
      case 'express':
        return const Color.fromARGB(255, 220, 123, 7);
      case 'super-express':
        return const Color.fromARGB(255, 229, 51, 51);
      default:
        return const Color.fromARGB(255, 128, 128, 128);
    }
  }

  IconData _getShippingIcon(String type) {
    switch (type) {
      case 'standard':
        return Icons.local_shipping;
      case 'express':
        return Icons.flash_on;
      case 'super-express':
        return Icons.rocket_launch;
      default:
        return Icons.local_shipping;
    }
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
