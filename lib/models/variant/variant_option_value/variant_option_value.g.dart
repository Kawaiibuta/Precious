// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_option_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VariantOptionValueImpl _$$VariantOptionValueImplFromJson(
        Map<String, dynamic> json) =>
    _$VariantOptionValueImpl(
      id: json['id'] as int? ?? null,
      option: Option.fromJson(json['option'] as Map<String, dynamic>),
      optionValue:
          OptionValue.fromJson(json['option_value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$VariantOptionValueImplToJson(
        _$VariantOptionValueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'option': instance.option,
      'option_value': instance.optionValue,
    };
