import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';
import 'package:techbox/src/features/payment/presentation/controller/payment_controller.dart';
import 'package:techbox/src/features/payment/presentation/state/payment_state.dart';

class StripeCheckoutWebView extends ConsumerStatefulWidget {
  final String checkoutUrl;
  final VoidCallback? onSuccess;
  final VoidCallback? onCancel;

  const StripeCheckoutWebView({
    Key? key,
    required this.checkoutUrl,
    this.onSuccess,
    this.onCancel,
  }) : super(key: key);

  @override
  ConsumerState<StripeCheckoutWebView> createState() => _StripeCheckoutWebViewState();
}

class _StripeCheckoutWebViewState extends ConsumerState<StripeCheckoutWebView> {
  late WebViewController _controller;
  bool isLoading = true;
  bool hasHandledSuccess = false; // Flag to prevent multiple calls

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
            // Reset flag when loading new page
            if (!url.contains('/payment/success')) {
              hasHandledSuccess = false;
            }
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            
            // Check for success URL and parse parameters (only once)
            if (url.contains('/payment/success')) {
              if (!hasHandledSuccess) {
                hasHandledSuccess = true;
                _handleSuccessUrl(url);
                
                // Fallback: Ensure navigation happens even if _handleSuccessUrl fails
                Future.delayed(const Duration(seconds: 5), () {
                  if (mounted && hasHandledSuccess) {
                    widget.onSuccess?.call();
                    Navigator.of(context).pop();
                  }
                });
              } else {
                if (mounted) {
                  widget.onSuccess?.call();
                  Navigator.of(context).pop();
                }
              }
            } else if (url.contains('cancel') || url.contains('error')) {
              widget.onCancel?.call();
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            // Handle navigation requests
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  void _handleSuccessUrl(String url) async {
    try {
      // Check if widget is still mounted before proceeding
      if (!mounted) {
        return;
      }
      
      // Parse URL parameters
      final uri = Uri.parse(url);
      final sessionId = uri.queryParameters['session_id'];
      final orderId = uri.queryParameters['orderId'];
      final voucherCode = uri.queryParameters['voucherCode'];
      
      if (sessionId != null && orderId != null) {
        // Update order payment status
        final updateRequest = UpdateOrderPaymentRequest(
          stripeSessionId: sessionId,
          orderId: orderId,
        );
        
        if (mounted) {
          await ref.read(paymentControllerProvider.notifier).updateOrderPayment(updateRequest);
          
          final currentState = ref.read(paymentControllerProvider);
          
          if (currentState is UpdateOrderPaymentSuccess) {
            // Navigate back immediately after successful update
            if (mounted) {
              widget.onSuccess?.call();
              Navigator.of(context).pop();
            }
          } else if (currentState is PaymentError) {
            // Still navigate back since payment was successful on Stripe
            if (mounted) {
              widget.onSuccess?.call();
              Navigator.of(context).pop();
            }
          }
        } else {
          if (mounted) {
            widget.onSuccess?.call();
            Navigator.of(context).pop();
          }
        }
      } else {
        // Navigate back even if parameters are missing
        if (mounted) {
          widget.onSuccess?.call();
          Navigator.of(context).pop();
        }
      }
      
    } catch (e) {
      // Navigate back on error
      if (mounted) {
        widget.onSuccess?.call();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            widget.onCancel?.call();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
} 