// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantOptionImpl _$$VariantOptionImplFromJson(Map<String, dynamic> json) =>
    _$VariantOptionImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      optionId: (json['option_id'] as num).toInt(),
      optionValue:
          OptionValue.fromJson(json['option_value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VariantOptionImplToJson(_$VariantOptionImpl instance) =>
    <String, dynamic>{};
