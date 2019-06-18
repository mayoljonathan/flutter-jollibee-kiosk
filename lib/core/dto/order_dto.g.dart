// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) {
  return OrderDto(
      serviceMode: _$enumDecode(_$ServiceModeEnumMap, json['serviceMode']),
      paymentType: _$enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      items: (json['items'] as List)
          .map((e) => MenuItemCart.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble());
}

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
      'serviceMode': _$ServiceModeEnumMap[instance.serviceMode],
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType],
      'items': instance.items.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$ServiceModeEnumMap = <ServiceMode, dynamic>{
  ServiceMode.DINE_IN: 'DINE_IN',
  ServiceMode.TAKE_OUT: 'TAKE_OUT'
};

const _$PaymentTypeEnumMap = <PaymentType, dynamic>{
  PaymentType.PAY_HERE: 'PAY_HERE',
  PaymentType.AT_COUNTER: 'AT_COUNTER'
};
