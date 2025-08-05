import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/common_widgets/success_notification.dart';
import 'package:techbox/src/features/auth/profile/presentation/controller/profile_controller.dart';
import 'package:techbox/src/features/auth/profile/presentation/state/profile_state.dart';
import 'package:techbox/src/features/cart/application/cart_services.dart';
import 'package:techbox/src/features/cart/domain/models/cart_product.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';
import 'package:techbox/src/features/payment/presentation/controller/payment_controller.dart';
import 'package:techbox/src/features/payment/presentation/state/payment_state.dart';
import 'package:techbox/src/features/payment/presentation/widgets/shipping_info_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/order_list_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/shipping_method_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/payment_method_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/voucher_selection_section.dart';
import 'package:techbox/src/features/payment/presentation/widgets/order_summary.dart';
import 'package:techbox/src/features/payment/presentation/widgets/bottom_button.dart';
import 'package:techbox/src/features/payment/presentation/widgets/stripe_checkout_webview.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';
import 'package:techbox/src/utils/checkout_helpers.dart';

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
  int shippingFee = 0;
  VoucherModel? selectedVoucher;
  final TextEditingController _discountController = TextEditingController();

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
                    const ShippingInfoSection(),
                    OrderListSection(cartItems: widget.cartItems),
                    ShippingMethodSection(
                      totalPrice: widget.totalPrice,
                      selectedShippingMethod: selectedShippingMethod,
                      onShippingMethodChanged: (index) {
                        setState(() {
                          selectedShippingMethod = index;
                        });
                      },
                      onShippingFeeChanged: (fee) {
                        setState(() {
                          shippingFee = fee;
                        });
                      },
                    ),

                    PaymentMethodSection(
                      selectedPaymentMethod: selectedPaymentMethod,
                      onPaymentMethodChanged: (index) {
                        setState(() {
                          selectedPaymentMethod = index;
                        });
                      },
                    ),

                    VoucherSelectionSection(
                      selectedVoucher: selectedVoucher,
                      onVoucherChanged: (voucher) {
                        setState(() {
                          selectedVoucher = voucher;
                        });
                      },
                    ),
                    _divider(),

                    Consumer(
                      builder: (context, ref, child) {
                        return OrderSummary(
                          subtotal: widget.totalPrice,
                          shippingFee: shippingFee,
                          discount: selectedVoucher?.discountAmount ?? 0,
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
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final paymentState = ref.watch(paymentControllerProvider);

          return BottomButton(
            buttonText:
                paymentState is PaymentLoading ? 'Đang xử lý...' : 'Đặt hàng',
            onPressed: () {
              if (paymentState is! PaymentLoading) {
                _handlePlaceOrder(ref);
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _handlePlaceOrder(WidgetRef ref) async {
    try {
      final profileState = ref.read(profileControllerProvider);
      if (profileState is! ProfileSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng cập nhật thông tin địa chỉ'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final orderRequest = CreateOrderRequest(
        variants:
            widget.cartItems
                .map(
                  (item) => OrderVariant(
                    variant: item.variantId,
                    quantity: item.quantity,
                  ),
                )
                .toList(),
        totalAmount: widget.totalPrice + shippingFee - (selectedVoucher?.discountAmount ?? 0),
        shippingAddress: CheckoutHelpers.formatAddress(
          profileState.response.address,
        ),
        paymentMethod: CheckoutHelpers.getPaymentMethod(selectedPaymentMethod),
        status: 'pending',
        voucherCode: selectedVoucher?.code ?? '',
      );

      await ref
          .read(paymentControllerProvider.notifier)
          .createOrder(orderRequest);

      final currentPaymentState = ref.read(paymentControllerProvider);
      if (currentPaymentState is CreateOrderSuccess) {
        final checkoutRequest = CreateCheckoutRequest(
          orderId: currentPaymentState.response.data.orderId,
          variants: currentPaymentState.response.data.variants,
        );

        await ref
            .read(paymentControllerProvider.notifier)
            .createCheckout(checkoutRequest);

        final checkoutState = ref.read(paymentControllerProvider);
        if (checkoutState is CreateCheckoutSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => StripeCheckoutWebView(
                    checkoutUrl: checkoutState.response.data.url,
                    onSuccess: () async {
                      await ref.read(cartServiceProvider).clearCart();
                      // Pop WebView and CheckoutPage
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop(); // Pop WebView
                      }
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop(); // Pop CheckoutPage
                      }

                      SuccessNotification.show(
                        context,
                        subtitleText: 'Chúc mừng bạn đã thanh toán thành công',
                        buttonText: 'OK',
                      );
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  ),
            ),
          );
        } else if (checkoutState is PaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi tạo checkout: ${checkoutState.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else if (currentPaymentState is PaymentError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi tạo đơn hàng: ${currentPaymentState.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Có lỗi xảy ra: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
