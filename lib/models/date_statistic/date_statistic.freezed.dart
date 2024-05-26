// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date_statistic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DateStatistic _$DateStatisticFromJson(Map<String, dynamic> json) {
  return _DateStatistic.fromJson(json);
}

/// @nodoc
mixin _$DateStatistic {
  @JsonKey(name: 'date', fromJson: dateTimeFromJson)
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: "orders")
  double get orders => throw _privateConstructorUsedError;
  @JsonKey(name: "new_users")
  double get newUsers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DateStatisticCopyWith<DateStatistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateStatisticCopyWith<$Res> {
  factory $DateStatisticCopyWith(
          DateStatistic value, $Res Function(DateStatistic) then) =
      _$DateStatisticCopyWithImpl<$Res, DateStatistic>;
  @useResult
  $Res call(
      {@JsonKey(name: 'date', fromJson: dateTimeFromJson) DateTime date,
      @JsonKey(name: "orders") double orders,
      @JsonKey(name: "new_users") double newUsers});
}

/// @nodoc
class _$DateStatisticCopyWithImpl<$Res, $Val extends DateStatistic>
    implements $DateStatisticCopyWith<$Res> {
  _$DateStatisticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? orders = null,
    Object? newUsers = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as double,
      newUsers: null == newUsers
          ? _value.newUsers
          : newUsers // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateStatisticImplCopyWith<$Res>
    implements $DateStatisticCopyWith<$Res> {
  factory _$$DateStatisticImplCopyWith(
          _$DateStatisticImpl value, $Res Function(_$DateStatisticImpl) then) =
      __$$DateStatisticImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'date', fromJson: dateTimeFromJson) DateTime date,
      @JsonKey(name: "orders") double orders,
      @JsonKey(name: "new_users") double newUsers});
}

/// @nodoc
class __$$DateStatisticImplCopyWithImpl<$Res>
    extends _$DateStatisticCopyWithImpl<$Res, _$DateStatisticImpl>
    implements _$$DateStatisticImplCopyWith<$Res> {
  __$$DateStatisticImplCopyWithImpl(
      _$DateStatisticImpl _value, $Res Function(_$DateStatisticImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? orders = null,
    Object? newUsers = null,
  }) {
    return _then(_$DateStatisticImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as double,
      newUsers: null == newUsers
          ? _value.newUsers
          : newUsers // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateStatisticImpl implements _DateStatistic {
  _$DateStatisticImpl(
      {@JsonKey(name: 'date', fromJson: dateTimeFromJson) required this.date,
      @JsonKey(name: "orders") this.orders = 0.0,
      @JsonKey(name: "new_users") this.newUsers = 0.0});

  factory _$DateStatisticImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateStatisticImplFromJson(json);

  @override
  @JsonKey(name: 'date', fromJson: dateTimeFromJson)
  final DateTime date;
  @override
  @JsonKey(name: "orders")
  final double orders;
  @override
  @JsonKey(name: "new_users")
  final double newUsers;

  @override
  String toString() {
    return 'DateStatistic(date: $date, orders: $orders, newUsers: $newUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateStatisticImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.orders, orders) || other.orders == orders) &&
            (identical(other.newUsers, newUsers) ||
                other.newUsers == newUsers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, orders, newUsers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DateStatisticImplCopyWith<_$DateStatisticImpl> get copyWith =>
      __$$DateStatisticImplCopyWithImpl<_$DateStatisticImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateStatisticImplToJson(
      this,
    );
  }
}

abstract class _DateStatistic implements DateStatistic {
  factory _DateStatistic(
      {@JsonKey(name: 'date', fromJson: dateTimeFromJson)
      required final DateTime date,
      @JsonKey(name: "orders") final double orders,
      @JsonKey(name: "new_users") final double newUsers}) = _$DateStatisticImpl;

  factory _DateStatistic.fromJson(Map<String, dynamic> json) =
      _$DateStatisticImpl.fromJson;

  @override
  @JsonKey(name: 'date', fromJson: dateTimeFromJson)
  DateTime get date;
  @override
  @JsonKey(name: "orders")
  double get orders;
  @override
  @JsonKey(name: "new_users")
  double get newUsers;
  @override
  @JsonKey(ignore: true)
  _$$DateStatisticImplCopyWith<_$DateStatisticImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
