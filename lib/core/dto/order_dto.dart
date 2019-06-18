import 'package:json_annotation/json_annotation.dart';
import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/core/viewmodels/payment_model.dart';

part 'order_dto.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class OrderDto {
  ServiceMode serviceMode;
  PaymentType paymentType;
  List<MenuItemCart> items;
  double totalPrice;

  OrderDto({
    this.serviceMode,
    this.paymentType,
    this.items,
    this.totalPrice
  });

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);
}
