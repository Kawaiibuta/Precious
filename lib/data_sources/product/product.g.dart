// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      name: json['name'] as String? ?? "",
      category_id: (json['category_id'] as num?)?.toInt() ?? -1,
      short_description: json['short_description'] as String? ?? "",
      description: json['description'] as String? ?? "",
      img_paths_url: (json['img_paths_url'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          null,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category_id': instance.category_id,
      'short_description': instance.short_description,
      'description': instance.description,
      'img_paths_url': instance.img_paths_url,
      'variants': instance.variants,
      'rating': instance.rating,
      'price': instance.price,
      'quantity': instance.quantity,
    };
