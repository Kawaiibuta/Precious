// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt() ?? null,
      name: json['name'] as String?,
      uid: json['uid'] as String,
      gender: (json['gender'] as num).toInt(),
      email: json['email'] as String?,
      age: (json['age'] as num?)?.toInt(),
      phoneNumber: json['phone_number'] as String?,
      userRole: json['userRole'] as String,
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      avatarUrl: json['avatar_img_path_url'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'uid': instance.uid,
      'gender': instance.gender,
      'email': instance.email,
      'age': instance.age,
      'phone_number': instance.phoneNumber,
      'userRole': instance.userRole,
      'addresses': instance.addresses,
      'orders': instance.orders,
      'avatar_img_path_url': instance.avatarUrl,
    };
