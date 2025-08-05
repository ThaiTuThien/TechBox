import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/core/theme/app_colors.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';
import 'package:techbox/src/features/voucher/presentation/controller/voucher_controller.dart';
import 'package:techbox/src/features/voucher/presentation/state/voucher_state.dart';
import 'package:techbox/src/features/voucher/presentation/widget/myvoucher.dart';

class VoucherSelectionSection extends ConsumerStatefulWidget {
  final VoucherModel? selectedVoucher;
  final Function(VoucherModel?) onVoucherChanged;

  const VoucherSelectionSection({
    Key? key,
    required this.selectedVoucher,
    required this.onVoucherChanged,
  }) : super(key: key);

  @override
  ConsumerState<VoucherSelectionSection> createState() => _VoucherSelectionSectionState();
  }

class _VoucherSelectionSectionState extends ConsumerState<VoucherSelectionSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(voucherControllerProvider.notifier).getVouchers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title: 'Thẻ giảm giá'),
        const SizedBox(height: 12),
        Consumer(
          builder: (context, ref, child) {
            final voucherState = ref.watch(voucherControllerProvider);
            return _buildVoucherContent(voucherState);
          },
        ),
        _divider(),
      ],
    );
  }

  Widget _buildVoucherContent(VoucherState voucherState) {
    return switch (voucherState) {
      VoucherLoading() => _buildLoadingState(),
      VoucherError(:final message) => _buildErrorState(message),
      VoucherSuccess(:final vouchers) => _buildVoucherList(vouchers),
      VoucherInitial() => _buildLoadingState(),
      _ => _buildLoadingState(),
    };
  }

  Widget _buildLoadingState() {
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
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text('Đang tải thẻ giảm giá...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
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
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Không thể tải thẻ giảm giá',
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
                ref.read(voucherControllerProvider.notifier).getVouchers();
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
    );
  }

  Widget _buildVoucherList(List<VoucherModel> vouchers) {
    if (vouchers.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Không có thẻ giảm giá nào',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        // Selected voucher display
        if (widget.selectedVoucher != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedVoucher!.code,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Giảm ${widget.selectedVoucher!.formattedDiscountAmount}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => widget.onVoucherChanged(null),
                  icon: const Icon(Icons.close, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        
        // Expandable voucher list
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Header
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyVoucherPage(
                        onVoucherSelected: (voucher) {
                          widget.onVoucherChanged(voucher);
                        },
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.local_offer_outlined, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text(
                        'Chọn thẻ giảm giá',
                        style: TextStyle(fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        '${vouchers.length} thẻ có sẵn',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
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
} 