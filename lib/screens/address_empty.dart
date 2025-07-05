import 'package:flutter/material.dart';
import 'package:techbox/components/app_bar.dart';
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
                  color: Color.fromARGB(128, 128, 128, 100),
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Vui lòng thêm địa chỉ mới',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(128, 128, 128, 100),
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Divider(
                  color: ConstantsColor.colorMain,
                  thickness: 2.0,
                  height: 20.0, 
                ),
              ),
              SizedBox(height: 10),
              Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Button với kích thước 24x24 chứa icon "+"
        SizedBox(
          width: 24.0,
          height: 24.0,
          child: ElevatedButton(
            onPressed: () {
              print('được nhấn rồi nè');
            },
            style: ElevatedButton.styleFrom(
             backgroundColor: ConstantsColor.colorMain,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.zero, 
            ),
            child: Image.asset('assets/image/add.png', width: 12, height: 12, color: Colors.white),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Thêm địa chỉ mới',
            style: TextStyle(
              color: ConstantsColor.colorMain,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
          ],
        ),
      ),
    );
  }
}