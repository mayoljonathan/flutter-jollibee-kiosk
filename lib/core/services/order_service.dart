import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jollibee_kiosk/core/dto/order_dto.dart';

class OrderService {

  Future<bool> sendOrder(OrderDto orderDto) async {
    print('[OrderService] sendOrder');
    print(orderDto.toJson());
    
    try {
      await Firestore.instance.collection('orders').add(orderDto.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}