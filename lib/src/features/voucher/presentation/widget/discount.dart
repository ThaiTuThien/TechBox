import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/voucher/presentation/controller/point_controller.dart';
import 'package:techbox/src/features/voucher/presentation/controller/voucher_controller.dart';
import 'package:techbox/src/features/voucher/presentation/state/point_state.dart';

class DiscountVoucher {
  final String name;
  final String description;
  final int amount;
  final int requiredPoint;
  const DiscountVoucher({
    required this.name,
    required this.description,
    required this.amount,
    required this.requiredPoint,
  });
}

const List<DiscountVoucher> discountVouchers = [
  DiscountVoucher(
    name: 'Voucher 100K',
    description: 'Giảm 100.000đ cho đơn hàng',
    amount: 100000,
    requiredPoint: 100,
  ),
  DiscountVoucher(
    name: 'Voucher 300K',
    description: 'Giảm 300.000đ cho đơn hàng',
    amount: 300000,
    requiredPoint: 300,
  ),
  DiscountVoucher(
    name: 'Voucher 1000K',
    description: 'Giảm 1.000.000đ cho đơn hàng',
    amount: 1000000,
    requiredPoint: 500,
  ),
];

class DiscountPage extends ConsumerStatefulWidget {
  const DiscountPage({super.key});

  @override
  ConsumerState<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends ConsumerState<DiscountPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pointControllerProvider.notifier).fetchPoints();
      ref.read(voucherControllerProvider.notifier).getVouchers();
    });
  }

  void _handleExchangeVoucher(DiscountVoucher voucherToExchange) {
    final pointState = ref.read(pointControllerProvider);

    if (pointState is PointSuccess &&
        voucherToExchange.requiredPoint > pointState.response.points) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn không đủ điểm để đổi voucher này!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Xác nhận đổi voucher'),
            content: Text(
              'Bạn chắc chắn muốn dùng ${voucherToExchange.requiredPoint} điểm để đổi ${voucherToExchange.name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantsColor.colorMain,
                ),
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  showDialog(
                    context: context,
                    builder:
                        (_) => const Center(child: CircularProgressIndicator()),
                    barrierDismissible: false,
                  );
                  try {
                    await ref
                        .read(voucherControllerProvider.notifier)
                        .exchangePointsForVoucher(voucherToExchange.requiredPoint);
                    await ref
                        .read(pointControllerProvider.notifier)
                        .refreshPoints();
                    await ref
                        .read(voucherControllerProvider.notifier)
                        .getVouchers();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Đổi voucher thành công!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Lỗi: ${e.toString().replaceAll("Exception: ", "")}',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Xác nhận'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    final pointState = ref.watch(pointControllerProvider);

    final availablePoint =
        (pointState is PointSuccess) ? pointState.response.points : 0;

    return Scaffold(
      appBar: AppBarComponent(
        title: "Đổi thẻ giảm giá",
        showBackButton: true,
        showBottomBorder: false,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child:
            (pointState is PointLoading || pointState is PointInitial)
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24.0 : 16.0,
                    vertical: 16,
                  ),
                  children: [
                    _PointCard(availablePoint: availablePoint),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        bottom: 12,
                        top: 2,
                      ),
                      child: Text(
                        "Đổi voucher giảm giá",
                        style: TextStyle(
                          color: ConstantsColor.colorMain,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.5,
                        ),
                      ),
                    ),
                    _VoucherList(
                      vouchers: discountVouchers,
                      onExchangeTap: (voucher) {
                        _handleExchangeVoucher(voucher);
                      },
                    ),
                    const SizedBox(height: 20),
                    const _NoteCard(),
                  ],
                ),
      ),
    );
  }
}

class _PointCard extends StatelessWidget {
  final int availablePoint;
  const _PointCard({required this.availablePoint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3C595D),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Image.asset('assets/image/start.png')),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Điểm tích lũy',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 1.14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Tỷ lệ: 100.000đ = 1 điểm',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text(
                  '$availablePoint',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 54,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'điểm có sẵn',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VoucherList extends StatelessWidget {
  final List<DiscountVoucher> vouchers;
  final Function(DiscountVoucher) onExchangeTap;
  const _VoucherList({required this.vouchers, required this.onExchangeTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DiscountVoucherCard(
            voucher: voucher,
            onTap: () => onExchangeTap(voucher),
          ),
        );
      },
    );
  }
}

class DiscountVoucherCard extends StatelessWidget {
  final DiscountVoucher voucher;
  final VoidCallback onTap;
  const DiscountVoucherCard({
    super.key,
    required this.voucher,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: const Icon(
              Icons.check_circle_outline,
              color: Color.fromARGB(255, 107, 114, 128),
              size: 18,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  voucher.description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Color(0xFFFFC107),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${voucher.requiredPoint} điểm",
                      style: const TextStyle(
                        color: Color(0xFFFFC107),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${NumberFormat('#,##0', 'vi_VN').format(voucher.amount)}đ',
                style: const TextStyle(
                  color: Color(0xFF3C595D),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.5,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF3C5A5D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text("Đổi ngay"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Lưu ý quan trọng",
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.bold,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 8),
          _buildNotePoint("Voucher có hiệu lực trong 30 ngày kể từ ngày đổi"),
          _buildNotePoint("Không thể hoàn lại điểm sau khi đã đổi voucher"),
          _buildNotePoint("Mỗi đơn hàng chỉ áp dụng được 1 voucher"),
        ],
      ),
    );
  }

  Widget _buildNotePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF415263),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13.5, color: Color(0xFF415263)),
            ),
          ),
        ],
      ),
    );
  }
}
