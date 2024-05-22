// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      userId: (json['user_id'] as num).toInt(),
      isPaid: json['is_paid'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      status: json['status'] as String,
      createAt: _sendDateTimeFromJson(json['created_at'] as String),
      totalPrice: (json['total_price'] as num).toDouble(),
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderedProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'address': instance.address,
      'phone_number': instance.phoneNumber,
      'items': instance.items,
    };
