// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String? ?? "",
      categoryId: (json['category_id'] as num?)?.toInt() ?? -1,
      shortDescription: json['short_description'] as String? ?? "",
      description: json['description'] as String? ?? "",
      imgPathUrls: (json['img_paths_url'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category_id': instance.categoryId,
      'short_description': instance.shortDescription,
      'description': instance.description,
      'rating': instance.rating,
    };
