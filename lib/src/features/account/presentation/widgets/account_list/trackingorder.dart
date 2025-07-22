import 'package:flutter/material.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          Column(
            children: [
              AppBarComponent(
                title: "Theo dõi đơn",
                showBackButton:
                    false, // Để false để dùng custom nút back ở dưới
                showBottomBorder: false,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Danh sách đơn hàng",
                          style: TextStyle(
                            color: Color(0xFF3C5A5D),
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            2,
                            (index) => const _ProductCard(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 28, color: Color(0xFFECECEC)),
                        const Text(
                          "Chi tiết đơn hàng",
                          style: TextStyle(
                            color: Color(0xFF3C5A5D),
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 9),
                        _DetailRow(
                          label: "Mã đơn hàng",
                          value: "67eea5e05764f7107a4700e5",
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.copy_rounded,
                              size: 20,
                              color: Color(0xFF3C5A5D),
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        const SizedBox(height: 4),
                        _DetailRow(
                          label: "Ngày đến dự kiến",
                          value: "08/07/2025",
                        ),
                        const Divider(height: 30, color: Color(0xFF3C5A5D)),
                        const Text(
                          "Trạng thái đơn hàng",
                          style: TextStyle(
                            color: Color(0xFF3C5A5D),
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _OrderTimeline(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Nếu muốn nút back custom nằm ngoài AppBar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 18,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 26, 26, 26), // Màu icon đen
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card sản phẩm trong đơn hàng
class _ProductCard extends StatelessWidget {
  const _ProductCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE9E9E9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/image/iphone14promax.png",
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "iPhone 14 Pro Max 256GB",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Color(0xFF3C5A5D),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "Màu :",
                      style: TextStyle(fontSize: 14, color: Color(0xFF3C5A5D)),
                    ),
                    SizedBox(width: 6),
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: Color(0xFF000000), // Đen
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Đen",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "12.000.000đ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF232323),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            width: 25,
            height: 25,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F2),
              shape: BoxShape.circle,
            ),
            child: const Text(
              "1",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF868686),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Row chi tiết đơn hàng
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;
  const _DetailRow({required this.label, required this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF3C5A5D), // Màu label sửa ở đây
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// Timeline trạng thái đơn hàng
class _OrderTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timelineColor = const Color(0xFF3C5A5D);

    final statuses = [
      {
        'label': 'Chờ xác nhận',
        'date': '09/07/2025, 00:45 PM',
        'icon': Icons.check_circle_rounded,
        'active': true,
      },
      {
        'label': 'Đang xử lý',
        'date': '09/07/2025, 00:45 PM',
        'icon': Icons.blur_circular_rounded,
        'active': true,
      },
      {
        'label': 'Đã gửi hàng',
        'date': '09/07/2025, 00:45 PM',
        'icon': Icons.local_shipping_outlined,
        'active': true,
      },
      {
        'label': 'Đã giao hàng',
        'date': '09/07/2025, 00:45 PM',
        'icon': Icons.check_circle_outline_rounded,
        'active': false,
      },
      {
        'label': 'Đã huỷ',
        'date': '09/07/2025, 00:45 PM',
        'icon': Icons.cancel_outlined,
        'active': false,
      },
    ];

    return Column(
      children: List.generate(statuses.length, (i) {
        final status = statuses[i];
        final isActive = status['active'] as bool;
        final isLast = i == statuses.length - 1;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    color: isActive ? timelineColor : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive ? timelineColor : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    status['icon'] as IconData,
                    size: 20,
                    color: isActive ? Colors.white : Colors.grey,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 3,
                    height: 42,
                    color: isActive ? timelineColor : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 2, bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          status['label'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:
                                isActive ? timelineColor : Colors.grey.shade500,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          status['icon'] as IconData,
                          color:
                              isActive ? timelineColor : Colors.grey.shade400,
                          size: 23,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      status['date'] as String,
                      style: TextStyle(
                        color: isActive ? Colors.black87 : Colors.grey.shade400,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
