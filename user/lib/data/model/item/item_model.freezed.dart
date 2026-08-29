// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ItemModel {

 int? get id; String? get name; String? get nameAr; String? get desc; String? get descAr; String? get image; int? get count; int? get active; double? get price; int? get discount; int? get categoryId; int? get deliveryTime; double? get discountedPrice; bool? get isFavorite; String? get updatedAt; CategoryModel? get category;
/// Create a copy of ItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemModelCopyWith<ItemModel> get copyWith => _$ItemModelCopyWithImpl<ItemModel>(this as ItemModel, _$identity);

  /// Serializes this ItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.descAr, descAr) || other.descAr == descAr)&&(identical(other.image, image) || other.image == image)&&(identical(other.count, count) || other.count == count)&&(identical(other.active, active) || other.active == active)&&(identical(other.price, price) || other.price == price)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameAr,desc,descAr,image,count,active,price,discount,categoryId,deliveryTime,discountedPrice,isFavorite,updatedAt,category);

@override
String toString() {
  return 'ItemModel(id: $id, name: $name, nameAr: $nameAr, desc: $desc, descAr: $descAr, image: $image, count: $count, active: $active, price: $price, discount: $discount, categoryId: $categoryId, deliveryTime: $deliveryTime, discountedPrice: $discountedPrice, isFavorite: $isFavorite, updatedAt: $updatedAt, category: $category)';
}


}

/// @nodoc
abstract mixin class $ItemModelCopyWith<$Res>  {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) _then) = _$ItemModelCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, String? nameAr, String? desc, String? descAr, String? image, int? count, int? active, double? price, int? discount, int? categoryId, int? deliveryTime, double? discountedPrice, bool? isFavorite, String? updatedAt, CategoryModel? category
});


$CategoryModelCopyWith<$Res>? get category;

}
/// @nodoc
class _$ItemModelCopyWithImpl<$Res>
    implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._self, this._then);

  final ItemModel _self;
  final $Res Function(ItemModel) _then;

/// Create a copy of ItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? nameAr = freezed,Object? desc = freezed,Object? descAr = freezed,Object? image = freezed,Object? count = freezed,Object? active = freezed,Object? price = freezed,Object? discount = freezed,Object? categoryId = freezed,Object? deliveryTime = freezed,Object? discountedPrice = freezed,Object? isFavorite = freezed,Object? updatedAt = freezed,Object? category = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,descAr: freezed == descAr ? _self.descAr : descAr // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,deliveryTime: freezed == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int?,discountedPrice: freezed == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as double?,isFavorite: freezed == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryModel?,
  ));
}
/// Create a copy of ItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [ItemModel].
extension ItemModelPatterns on ItemModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemModel value)  $default,){
final _that = this;
switch (_that) {
case _ItemModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _ItemModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  String? nameAr,  String? desc,  String? descAr,  String? image,  int? count,  int? active,  double? price,  int? discount,  int? categoryId,  int? deliveryTime,  double? discountedPrice,  bool? isFavorite,  String? updatedAt,  CategoryModel? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemModel() when $default != null:
return $default(_that.id,_that.name,_that.nameAr,_that.desc,_that.descAr,_that.image,_that.count,_that.active,_that.price,_that.discount,_that.categoryId,_that.deliveryTime,_that.discountedPrice,_that.isFavorite,_that.updatedAt,_that.category);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  String? nameAr,  String? desc,  String? descAr,  String? image,  int? count,  int? active,  double? price,  int? discount,  int? categoryId,  int? deliveryTime,  double? discountedPrice,  bool? isFavorite,  String? updatedAt,  CategoryModel? category)  $default,) {final _that = this;
switch (_that) {
case _ItemModel():
return $default(_that.id,_that.name,_that.nameAr,_that.desc,_that.descAr,_that.image,_that.count,_that.active,_that.price,_that.discount,_that.categoryId,_that.deliveryTime,_that.discountedPrice,_that.isFavorite,_that.updatedAt,_that.category);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  String? nameAr,  String? desc,  String? descAr,  String? image,  int? count,  int? active,  double? price,  int? discount,  int? categoryId,  int? deliveryTime,  double? discountedPrice,  bool? isFavorite,  String? updatedAt,  CategoryModel? category)?  $default,) {final _that = this;
switch (_that) {
case _ItemModel() when $default != null:
return $default(_that.id,_that.name,_that.nameAr,_that.desc,_that.descAr,_that.image,_that.count,_that.active,_that.price,_that.discount,_that.categoryId,_that.deliveryTime,_that.discountedPrice,_that.isFavorite,_that.updatedAt,_that.category);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ItemModel extends ItemModel {
  const _ItemModel({this.id, this.name, this.nameAr, this.desc, this.descAr, this.image, this.count, this.active, this.price, this.discount, this.categoryId, this.deliveryTime, this.discountedPrice, this.isFavorite, this.updatedAt, this.category}): super._();
  factory _ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

@override final  int? id;
@override final  String? name;
@override final  String? nameAr;
@override final  String? desc;
@override final  String? descAr;
@override final  String? image;
@override final  int? count;
@override final  int? active;
@override final  double? price;
@override final  int? discount;
@override final  int? categoryId;
@override final  int? deliveryTime;
@override final  double? discountedPrice;
@override final  bool? isFavorite;
@override final  String? updatedAt;
@override final  CategoryModel? category;

/// Create a copy of ItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemModelCopyWith<_ItemModel> get copyWith => __$ItemModelCopyWithImpl<_ItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.descAr, descAr) || other.descAr == descAr)&&(identical(other.image, image) || other.image == image)&&(identical(other.count, count) || other.count == count)&&(identical(other.active, active) || other.active == active)&&(identical(other.price, price) || other.price == price)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.deliveryTime, deliveryTime) || other.deliveryTime == deliveryTime)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nameAr,desc,descAr,image,count,active,price,discount,categoryId,deliveryTime,discountedPrice,isFavorite,updatedAt,category);

@override
String toString() {
  return 'ItemModel(id: $id, name: $name, nameAr: $nameAr, desc: $desc, descAr: $descAr, image: $image, count: $count, active: $active, price: $price, discount: $discount, categoryId: $categoryId, deliveryTime: $deliveryTime, discountedPrice: $discountedPrice, isFavorite: $isFavorite, updatedAt: $updatedAt, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ItemModelCopyWith<$Res> implements $ItemModelCopyWith<$Res> {
  factory _$ItemModelCopyWith(_ItemModel value, $Res Function(_ItemModel) _then) = __$ItemModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, String? nameAr, String? desc, String? descAr, String? image, int? count, int? active, double? price, int? discount, int? categoryId, int? deliveryTime, double? discountedPrice, bool? isFavorite, String? updatedAt, CategoryModel? category
});


@override $CategoryModelCopyWith<$Res>? get category;

}
/// @nodoc
class __$ItemModelCopyWithImpl<$Res>
    implements _$ItemModelCopyWith<$Res> {
  __$ItemModelCopyWithImpl(this._self, this._then);

  final _ItemModel _self;
  final $Res Function(_ItemModel) _then;

/// Create a copy of ItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? nameAr = freezed,Object? desc = freezed,Object? descAr = freezed,Object? image = freezed,Object? count = freezed,Object? active = freezed,Object? price = freezed,Object? discount = freezed,Object? categoryId = freezed,Object? deliveryTime = freezed,Object? discountedPrice = freezed,Object? isFavorite = freezed,Object? updatedAt = freezed,Object? category = freezed,}) {
  return _then(_ItemModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameAr: freezed == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,descAr: freezed == descAr ? _self.descAr : descAr // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,active: freezed == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,discount: freezed == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,deliveryTime: freezed == deliveryTime ? _self.deliveryTime : deliveryTime // ignore: cast_nullable_to_non_nullable
as int?,discountedPrice: freezed == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as double?,isFavorite: freezed == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as CategoryModel?,
  ));
}

/// Create a copy of ItemModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryModelCopyWith<$Res>? get category {
    if (_self.category == null) {
    return null;
  }

  return $CategoryModelCopyWith<$Res>(_self.category!, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

// dart format on
