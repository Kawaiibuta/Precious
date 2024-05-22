// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantImpl _$$VariantImplFromJson(Map<String, dynamic> json) =>
    _$VariantImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      productId: (json['product_id'] as num).toInt(),
      variantOptionValues: (json['variant_option_values'] as List<dynamic>?)
          ?.map((e) => VariantOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      imgPathUrls: (json['img_paths_url'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$VariantImplToJson(_$VariantImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'product_id': instance.productId,
    };
