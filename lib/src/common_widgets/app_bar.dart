import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showBottomBorder;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;

  const AppBarComponent({
    Key? key,
    this.title = 'Giỏ hàng',
    this.showBackButton = true,
    this.showBottomBorder = true,
    this.onBackPressed, 
    this.onNotificationPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(
        showBottomBorder ? kToolbarHeight + 1.0 : kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Column(
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    // Back Button
                    if (showBackButton)
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 24,
                        ),
                        onPressed: onBackPressed ?? () => Navigator.pop(context),
                      )
                    else
                      const SizedBox(width: 48), 
                    // Title
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 26, 26, 26),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    // Notification Button
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 24,
                      ),
                      onPressed: onNotificationPressed ?? () {},
                    ),
                  ],
                ),
              ),
              
              // Bottom Border
              if (showBottomBorder)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 1.0,
                  color: const Color.fromARGB(255, 230, 230, 230),
                ),
            ],
          ),
        ),
      ),
    );
  }
}