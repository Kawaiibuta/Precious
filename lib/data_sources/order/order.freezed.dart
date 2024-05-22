// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  @JsonKey(includeToJson: false)
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "user_id")
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "is_paid", includeToJson: false)
  bool get isPaid => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  String get status => throw _privateConstructorUsedError;
  @JsonKey(
      name: "created_at", fromJson: _sendDateTimeFromJson, includeToJson: false)
  DateTime? get createAt => throw _privateConstructorUsedError;
  @JsonKey(name: "total_price", includeToJson: false)
  double get totalPrice => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: "phone_number")
  String? get phoneNumber => throw _privateConstructorUsedError;
  List<OrderedProduct> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: "user_id") int userId,
      @JsonKey(name: "is_paid", includeToJson: false) bool isPaid,
      @JsonKey(includeToJson: false) User? user,
      @JsonKey(includeToJson: false) String status,
      @JsonKey(
          name: "created_at",
          fromJson: _sendDateTimeFromJson,
          includeToJson: false)
      DateTime? createAt,
      @JsonKey(name: "total_price", includeToJson: false) double totalPrice,
      String address,
      @JsonKey(name: "phone_number") String? phoneNumber,
      List<OrderedProduct> items});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? isPaid = null,
    Object? user = freezed,
    Object? status = null,
    Object? createAt = freezed,
    Object? totalPrice = null,
    Object? address = null,
    Object? phoneNumber = freezed,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderedProduct>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) int? id,
      @JsonKey(name: "user_id") int userId,
      @JsonKey(name: "is_paid", includeToJson: false) bool isPaid,
      @JsonKey(includeToJson: false) User? user,
      @JsonKey(includeToJson: false) String status,
      @JsonKey(
          name: "created_at",
          fromJson: _sendDateTimeFromJson,
          includeToJson: false)
      DateTime? createAt,
      @JsonKey(name: "total_price", includeToJson: false) double totalPrice,
      String address,
      @JsonKey(name: "phone_number") String? phoneNumber,
      List<OrderedProduct> items});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? isPaid = null,
    Object? user = freezed,
    Object? status = null,
    Object? createAt = freezed,
    Object? totalPrice = null,
    Object? address = null,
    Object? phoneNumber = freezed,
    Object? items = null,
  }) {
    return _then(_$OrderImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderedProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl with DiagnosticableTreeMixin implements _Order {
  const _$OrderImpl(
      {@JsonKey(includeToJson: false) this.id = null,
      @JsonKey(name: "user_id") required this.userId,
      @JsonKey(name: "is_paid", includeToJson: false) required this.isPaid,
      @JsonKey(includeToJson: false) this.user,
      @JsonKey(includeToJson: false) required this.status,
      @JsonKey(
          name: "created_at",
          fromJson: _sendDateTimeFromJson,
          includeToJson: false)
      required this.createAt,
      @JsonKey(name: "total_price", includeToJson: false)
      required this.totalPrice,
      required this.address,
      @JsonKey(name: "phone_number") this.phoneNumber,
      this.items = const []});

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final int? id;
  @override
  @JsonKey(name: "user_id")
  final int userId;
  @override
  @JsonKey(name: "is_paid", includeToJson: false)
  final bool isPaid;
  @override
  @JsonKey(includeToJson: false)
  final User? user;
  @override
  @JsonKey(includeToJson: false)
  final String status;
  @override
  @JsonKey(
      name: "created_at", fromJson: _sendDateTimeFromJson, includeToJson: false)
  final DateTime? createAt;
  @override
  @JsonKey(name: "total_price", includeToJson: false)
  final double totalPrice;
  @override
  final String address;
  @override
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @override
  @JsonKey()
  final List<OrderedProduct> items;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Order(id: $id, userId: $userId, isPaid: $isPaid, user: $user, status: $status, createAt: $createAt, totalPrice: $totalPrice, address: $address, phoneNumber: $phoneNumber, items: $items)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Order'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('isPaid', isPaid))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createAt', createAt))
      ..add(DiagnosticsProperty('totalPrice', totalPrice))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('phoneNumber', phoneNumber))
      ..add(DiagnosticsProperty('items', items));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      isPaid,
      user,
      status,
      createAt,
      totalPrice,
      address,
      phoneNumber,
      const DeepCollectionEquality().hash(items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {@JsonKey(includeToJson: false) final int? id,
      @JsonKey(name: "user_id") required final int userId,
      @JsonKey(name: "is_paid", includeToJson: false)
      required final bool isPaid,
      @JsonKey(includeToJson: false) final User? user,
      @JsonKey(includeToJson: false) required final String status,
      @JsonKey(
          name: "created_at",
          fromJson: _sendDateTimeFromJson,
          includeToJson: false)
      required final DateTime? createAt,
      @JsonKey(name: "total_price", includeToJson: false)
      required final double totalPrice,
      required final String address,
      @JsonKey(name: "phone_number") final String? phoneNumber,
      final List<OrderedProduct> items}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  int? get id;
  @override
  @JsonKey(name: "user_id")
  int get userId;
  @override
  @JsonKey(name: "is_paid", includeToJson: false)
  bool get isPaid;
  @override
  @JsonKey(includeToJson: false)
  User? get user;
  @override
  @JsonKey(includeToJson: false)
  String get status;
  @override
  @JsonKey(
      name: "created_at", fromJson: _sendDateTimeFromJson, includeToJson: false)
  DateTime? get createAt;
  @override
  @JsonKey(name: "total_price", includeToJson: false)
  double get totalPrice;
  @override
  String get address;
  @override
  @JsonKey(name: "phone_number")
  String? get phoneNumber;
  @override
  List<OrderedProduct> get items;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
