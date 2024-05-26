// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordered_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderedProductImpl _$$OrderedProductImplFromJson(Map<String, dynamic> json) =>
    _$OrderedProductImpl(
      id: (json['id'] as num?)?.toInt(),
      variantId: (json['variant_id'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$OrderedProductImplToJson(
        _$OrderedProductImpl instance) =>
    <String, dynamic>{
      'variant_id': instance.variantId,
      'quantity': instance.quantity,
    };
