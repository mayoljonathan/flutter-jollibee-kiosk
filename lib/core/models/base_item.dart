import 'package:intl/intl.dart';

class BaseItem {
  final double price;

  BaseItem({this.price});

  String priceToString() {
    if (this.price != null) {
      final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: 2);
      return '₱ ${formatter.format(price)}';
    }
    return '';
  }
}