// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      id: (json['id'] as num).toInt(),
      cart: json['cart'] as String?,
      variant: Variant.fromJson(json['variant'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cart': instance.cart,
      'variant': instance.variant,
      'quantity': instance.quantity,
      'price': instance.price,
    };
