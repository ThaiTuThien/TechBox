import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techbox/src/common_widgets/app_bar.dart';

class MyVoucherPage extends StatelessWidget {
  final List<Map<String, dynamic>> vouchers = [
    {
      "code": "TECHBOX100K",
      "desc": "Giảm 100.000đ cho đơn hàng",
      "expiry": "30/07/2025",
      "isActive": true,
    },
    {
      "code": "TECHBOX100K",
      "desc": "Giảm 100.000đ cho đơn hàng",
      "expiry": "30/07/2025",
      "isActive": true,
    },
    {
      "code": "TECHBOX100K",
      "desc": "Giảm 100.000đ cho đơn hàng",
      "expiry": "30/07/2025",
      "isActive": true,
    },
    {
      "code": "TECHBOX100K",
      "desc": "Giảm 100.000đ cho đơn hàng",
      "expiry": "30/07/2025",
      "isActive": false,
    },
  ];

  MyVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: "Voucher của tôi",
        showBackButton: true,
        showBottomBorder: false,
        onBackPressed: () => Navigator.pop(context),
        onNotificationPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children:
                vouchers.map((voucher) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF3C5A5D), width: 1.3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon voucher
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
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Info + trạng thái + sao chép
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  voucher["code"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  voucher["desc"],
                                  style: const TextStyle(
                                    fontSize: 13.7,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Hết hạn: ${voucher["expiry"]}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/image/voucher.png',
                                          width: 13,
                                          height: 13,
                                          color:
                                              voucher["isActive"]
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          voucher["isActive"]
                                              ? "Còn hiệu lực"
                                              : "Hết hiệu lực",
                                          style: TextStyle(
                                            color:
                                                voucher["isActive"]
                                                    ? Colors.green
                                                    : Colors.red,
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
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        minimumSize: Size(0, 0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
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
                                        Clipboard.setData(
                                          ClipboardData(text: voucher["code"]),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Đã sao chép mã ${voucher["code"]}!",
                                            ),
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
                }).toList(),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFFDF6F6),
    );
  }
}
