import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int rating = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Đơn hàng của bạn như thế nào?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 33,
                  ),
                  onPressed: () => setState(() => rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              minLines: 2,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Viết về cảm nhận của bạn",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Gửi đánh giá ở đây (thêm logic API nếu cần)
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF314B52),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Gửi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
