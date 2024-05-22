// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OptionImpl _$$OptionImplFromJson(Map<String, dynamic> json) => _$OptionImpl(
      id: json['id'] as int? ?? null,
      productId: json['product_id'] as int?,
      name: json['name'] as String?,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => OptionValue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OptionValue>[],
    );

Map<String, dynamic> _$$OptionImplToJson(_$OptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'name': instance.name,
      'values': instance.values,
    };
