// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      userId: (json['user_id'] as num?)?.toInt() ?? null,
      status: json['status'] as String,
      createAt: json['created_at'] == null
          ? null
          : _sendDateTimeFromJson(json['created_at'] as String),
      totalPrice: (json['total_price'] as num).toDouble(),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderedProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'status': instance.status,
      'created_at': instance.createAt?.toIso8601String(),
      'total_price': instance.totalPrice,
      'items': instance.items,
    };
