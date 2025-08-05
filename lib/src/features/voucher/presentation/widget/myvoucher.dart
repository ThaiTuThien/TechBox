import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';
import 'package:techbox/src/features/voucher/presentation/controller/voucher_controller.dart';
import 'package:techbox/src/features/voucher/presentation/state/voucher_list_state.dart';

class MyVoucherPage extends ConsumerWidget {
  const MyVoucherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucherState = ref.watch(voucherListControllerProvider);

    return Scaffold(
      appBar: AppBarComponent(
        title: "Voucher của tôi",
        showBackButton: true,
        showBottomBorder: false,
        onBackPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.white,

      body: switch (voucherState) {
        VoucherListLoading() || VoucherListInitial() => const Center(
          child: CircularProgressIndicator(),
        ),

        VoucherListError(message: final msg) => Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Lỗi tải voucher: $msg',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),

        VoucherListSuccess(vouchers: final vouchers) =>
          vouchers.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.card_giftcard, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "Bạn chưa có voucher nào",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(18.0),
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  return _VoucherItemCard(voucher: voucher);
                },
              ),
      },
    );
  }
}

class _VoucherItemCard extends StatelessWidget {
  final VoucherModel voucher;
  const _VoucherItemCard({required this.voucher});

  @override
  Widget build(BuildContext context) {
    final bool isActive =
        voucher.status == 'unused' && voucher.validTo.isAfter(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Colors.grey.shade300 : Colors.red,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  'assets/image/voucher.png',
                  width: 26,
                  height: 26,
                  color: const Color.fromARGB(255, 107, 114, 128),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Giảm ${voucher.formattedDiscountAmount}",
                    style: const TextStyle(
                      fontSize: 13.7,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Hết hạn: ${voucher.formattedValidTo}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 14,
                            color: isActive ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isActive ? "Còn hiệu lực" : "Đã hết hiệu lực",
                            style: TextStyle(
                              color: isActive ? Colors.green : Colors.red,
                              fontSize: 13.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor: Colors.grey.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(
                          Icons.copy,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                        label: const Text(
                          "Sao chép",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.5,
                          ),
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: voucher.code));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Đã sao chép mã ${voucher.code}!"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
