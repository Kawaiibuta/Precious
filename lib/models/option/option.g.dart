// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      name: json['name'] as String,
      productId: (json['product_id'] as num?)?.toInt(),
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => OptionValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product_id': instance.productId,
      'values': instance.values,
    };
