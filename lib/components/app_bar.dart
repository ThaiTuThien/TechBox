import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showBottomBorder;

  const AppBarComponent({
    Key? key,
    this.title = 'Giỏ hàng',
    this.showBackButton = true,
    this.showBottomBorder = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(
        showBottomBorder ? kToolbarHeight + 1.0 : kToolbarHeight,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 26, 26, 26),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/image/notification.png',
              width: 18.75,
              height: 20.25,
            ),
            onPressed: () {},
          ),
        ],
        bottom: showBottomBorder
            ? PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  height: 1.0,
                  color: const Color.fromARGB(255, 230, 230, 230),
                ),
              )
            : null,
      ),
    );
  }
}