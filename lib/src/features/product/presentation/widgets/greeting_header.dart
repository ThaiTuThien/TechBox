import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techbox/src/core/theme/app_colors.dart';

class GreetingHeader extends StatelessWidget {
  final String username;
  final String? avatar;
  const GreetingHeader({super.key, required this.username, this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: SvgPicture.network(
                    'https://api.dicebear.com/6.x/initials/svg?seed=$username',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    placeholderBuilder:
                        (context) => CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Xin chào, $username ✨', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 2),
                  Text(
                    'Khám phá công nghệ Apple nào!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications,
                size: 24,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
