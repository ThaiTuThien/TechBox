import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

// --- List voucher để ngoài để không bị khởi tạo lại nhiều lần ---
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

class DiscountPage extends StatelessWidget {
  final int availablePoint;
  const DiscountPage({super.key, this.availablePoint = 1250});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        title: "Đổi thẻ giảm giá",
        showBackButton: true,
        showBottomBorder: false,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          children: [
            _PointCard(availablePoint: availablePoint),
            const SizedBox(height: 2),
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 12, top: 2),
              child: Text(
                "Đổi voucher giảm giá",
                style: TextStyle(
                  color: Color(0xFF415263),
                  fontWeight: FontWeight.w700,
                  fontSize: 16.5,
                ),
              ),
            ),
            _VoucherList(vouchers: discountVouchers),
            const _NoteCard(),
          ],
        ),
      ),
    );
  }
}

// --- Card điểm tích lũy ---
class _PointCard extends StatelessWidget {
  final int availablePoint;
  const _PointCard({required this.availablePoint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF466668),
        borderRadius: BorderRadius.circular(32),
      ),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(36, 32, 36, 36),
      margin: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFC107),
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(width: 26),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Điểm tích lũy',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          height: 1.14,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Tỷ lệ: 100.000đ = 1 điểm',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36),
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
                const SizedBox(height: 8),
                const Text(
                  'điểm có sẵn',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
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

// --- Danh sách voucher ---
class _VoucherList extends StatelessWidget {
  final List<DiscountVoucher> vouchers;
  const _VoucherList({required this.vouchers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vouchers.length,
      itemBuilder: (context, index) {
        final voucher = vouchers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE7E7E7)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DiscountVoucherCard(
            voucher: voucher,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bạn đã nhận voucher: ${voucher.name}')),
              );
            },
          ),
        );
      },
    );
  }
}

// --- Card Lưu ý ---
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
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lưu ý quan trọng",
            style: TextStyle(
              color: Color(0xFF3C595D),
              fontWeight: FontWeight.bold,
              fontSize: 15.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "• Voucher có hiệu lực trong 30 ngày kể từ ngày đổi",
            style: TextStyle(fontSize: 13.5, color: Color(0xFF415263)),
          ),
          Text(
            "• Không thể hoàn lại điểm sau khi đã đổi voucher",
            style: TextStyle(fontSize: 13.5, color: Color(0xFF415263)),
          ),
          Text(
            "• Mỗi đơn hàng chỉ áp dụng được 1 voucher",
            style: TextStyle(fontSize: 13.5, color: Color(0xFF415263)),
          ),
        ],
      ),
    );
  }
}

// --- Card voucher ---
class DiscountVoucherCard extends StatelessWidget {
  final DiscountVoucher voucher;
  final VoidCallback onTap;

  const DiscountVoucherCard({
    super.key,
    required this.voucher,
    required this.onTap,
  });

  String _formatCurrency(int amount) {
    final str = amount.toString();
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(reg, (match) => ".") + "đ";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 3),
            child: const Icon(
              Icons.radio_button_unchecked,
              color: Color(0xFFB4B4B4),
              size: 25,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  voucher.description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF525252),
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 19,
                      color: Color(0xFFFFA726),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "${voucher.requiredPoint} điểm",
                      style: const TextStyle(
                        color: Color(0xFFFFA726),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatCurrency(voucher.amount),
                style: const TextStyle(
                  color: Color(0xFF3C595D),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.5,
                ),
              ),
              const SizedBox(height: 12),
              // Nút đã chỉnh to màu, radius, font y hình mẫu
              SizedBox(
                width: 120,
                height: 44,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF3C5A5D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
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

// --- Model Voucher ---
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
