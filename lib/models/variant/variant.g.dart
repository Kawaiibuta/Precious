// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantImpl _$$VariantImplFromJson(Map<String, dynamic> json) =>
    _$VariantImpl(
      id: json['id'] as int? ?? null,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      img_paths_url: (json['img_paths_url'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      variantOptionValues: (json['variant_option_values'] as List<dynamic>?)
              ?.map(
                  (e) => VariantOptionValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VariantOptionValue>[],
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VariantImplToJson(_$VariantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'img_paths_url': instance.img_paths_url,
      'variant_option_values': instance.variantOptionValues,
      'product': instance.product,
    };
