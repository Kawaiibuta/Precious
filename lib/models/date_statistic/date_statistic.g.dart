// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DateStatisticImpl _$$DateStatisticImplFromJson(Map<String, dynamic> json) =>
    _$DateStatisticImpl(
      date: dateTimeFromJson(json['date'] as String),
      orders: (json['orders'] as num?)?.toDouble() ?? 0.0,
      newUsers: (json['new_users'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DateStatisticImplToJson(_$DateStatisticImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'orders': instance.orders,
      'new_users': instance.newUsers,
    };
