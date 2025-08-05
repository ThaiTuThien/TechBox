import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/constants.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';
import 'package:techbox/src/features/voucher/presentation/controller/point_controller.dart';
import 'package:techbox/src/features/voucher/presentation/controller/voucher_controller.dart';
import 'package:techbox/src/features/voucher/presentation/state/point_state.dart';
import 'package:techbox/src/features/voucher/presentation/state/voucher_list_state.dart';

class VoucherScreen extends ConsumerStatefulWidget {
  const VoucherScreen({super.key});

  @override
  ConsumerState<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends ConsumerState<VoucherScreen> {
  final TextEditingController _pointsController = TextEditingController();
  int requiredPoints = 1000;
  List<int> presetAmounts = [100, 300, 500];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pointControllerProvider.notifier).fetchPoints();
      ref.read(voucherListControllerProvider.notifier).fetchVouchers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pointControllerProvider);
    final voucherListState = ref.watch(voucherListControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Đổi điểm lấy voucher',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32.0 : 16.0,
            vertical: 16.0,
          ),
          child: _buildBody(state, voucherListState),
        ),
      ),
    );
  }

  Widget _buildBody(PointState state, VoucherListState voucherListState) {
    if (state is PointLoading ||
        state is PointInitial ||
        voucherListState is VoucherListLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is PointError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Text(
            'Đã xảy ra lỗi: ${state.message}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    if (voucherListState is VoucherListError) {
      return Center(
        child: Text(
          'Lỗi tải voucher: ${voucherListState.message}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (state is PointSuccess && voucherListState is VoucherListSuccess) {
      final int currentPoints = state.response.points;
      final List<VoucherModel> vouchers = voucherListState.vouchers;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsCard(currentPoints),
          const SizedBox(height: 20),
          _buildExchangeCard(),
          const SizedBox(height: 20),
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildVoucherSection(vouchers),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPointsCard(int currentPoints) {
    double progress = currentPoints / requiredPoints;
    if (progress > 1.0) progress = 1.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ConstantsColor.colorMain.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.monetization_on,
              color: ConstantsColor.colorMain,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$currentPoints',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Điểm của bạn',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: ConstantsColor.colorMain,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              children: [
                const TextSpan(text: 'Cần thêm '),
                TextSpan(
                  text:
                      '${requiredPoints - currentPoints > 0 ? requiredPoints - currentPoints : 0} điểm',
                  style: TextStyle(
                    color: ConstantsColor.colorMain,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' để đổi voucher tiếp theo'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ConstantsColor.colorMain.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: ConstantsColor.colorMain,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Đổi điểm lấy voucher',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _pointsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Nhập số điểm muốn đổi',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ConstantsColor.colorMain),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ConstantsColor.colorMain.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle exchange logic
                    _showExchangeDialog(ref);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstantsColor.colorMain,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.swap_horiz, size: 18),
                      const SizedBox(width: 8),
                      const Text(
                        'Đổi ngay',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                presetAmounts.map((amount) {
                  return InkWell(
                    onTap: () {
                      _pointsController.text = amount.toString();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        '${amount}đ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2196F3).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF2196F3),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Điều lệ đổi điểm',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoItem('1 điểm = 100.000'),
          _buildInfoItem('voucher 100đ = 100.000'),
          _buildInfoItem('voucher 300đ = 500.000'),
          _buildInfoItem('voucher 500đ = 1.000.000'),
          _buildInfoItem('Voucher không hoàn lại điểm'),
          _buildInfoItem('Voucher có hạn sử dụng 30 ngày kể từ ngày đổi'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF2196F3),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1976D2),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherSection(List<VoucherModel> vouchers) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ConstantsColor.colorMain.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_offer,
                  color: ConstantsColor.colorMain,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Voucher của bạn',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          if (vouchers.isEmpty) ...[
            const SizedBox(height: 40),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: ConstantsColor.colorMain.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.card_giftcard,
                color: ConstantsColor.colorMain,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Bạn chưa có voucher nào'),
            const SizedBox(height: 8),
            const Text('Hãy đổi điểm để nhận voucher đầu tiên!'),
          ] else ...[
            const SizedBox(height: 16),

            Column(
              children:
                  vouchers
                      .map((voucher) => _buildVoucherCard(voucher))
                      .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVoucherCard(VoucherModel voucher) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ConstantsColor.colorMain.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.local_offer,
              color: ConstantsColor.colorMain,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Giảm ${voucher.formattedDiscountAmount}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mã: ${voucher.code}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'HSD: ${voucher.formattedValidTo}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              //thêm logic copy vô sau nha mấy e
            },
            icon: Icon(Icons.copy, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _showExchangeDialog(WidgetRef ref) {
    final pointsText = _pointsController.text;
    if (pointsText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số điểm muốn đổi!')),
      );
      return;
    }
    final pointsToExchange = int.tryParse(pointsText);
    if (pointsToExchange == null || pointsToExchange <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Số điểm không hợp lệ!')));
      return;
    }

    final pointState = ref.read(pointControllerProvider);
    if (pointState is PointSuccess &&
        pointsToExchange > pointState.response.points) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn không đủ điểm để thực hiện giao dịch này!'),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Xác nhận đổi điểm'),
          content: Text('Bạn chắc chắn muốn đổi $pointsToExchange điểm?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder:
                      (loadingContext) =>
                          const Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                final pointState = ref.read(pointControllerProvider);

                if (pointState is! PointSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Không thể lấy được điểm hiện tại, vui lòng thử lại!',
                      ),
                    ),
                  );
                  return;
                }

                if (pointsToExchange > pointState.response.points) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Bạn không đủ điểm để thực hiện giao dịch này!',
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder:
                      (context) =>
                          const Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                try {
                  await ref
                      .read(voucherListControllerProvider.notifier)
                      .exchangePoints(pointsToExchange);

                  await ref
                      .read(pointControllerProvider.notifier)
                      .refreshPoints();

                  Navigator.of(context, rootNavigator: true).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Đổi điểm thành công! Voucher mới đã được thêm vào.',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  Navigator.of(context, rootNavigator: true).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString().replaceAll("Exception: ", "")),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }
}
