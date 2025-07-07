import 'package:flutter/material.dart';
import 'package:techbox/components/app_bar.dart';
import 'package:techbox/components/dashed_button.dart';
import 'package:techbox/core/constants.dart';


class AddressEmpty extends StatelessWidget {
  const AddressEmpty({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarCart(title: 'Địa chỉ nhận hàng',),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/image/address.png',
                width: 64,
                height: 64,
              ),
              SizedBox(height: 16),
              Text(
                'Không có địa chỉ nào được lưu',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Vui lòng thêm địa chỉ mới',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 20),
              DashedAddAddressButton(
                onPressed: () {
                  print('Được nhấn rồi nè ba');
                },
              )
          ],
        ),
      ),
    );
  }
}