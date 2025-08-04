import 'package:intl/intl.dart';

String formatCurrency(int price) {
  final format = NumberFormat.decimalPattern('vi_VN');
  return "${format.format(price)}đ"; 
}