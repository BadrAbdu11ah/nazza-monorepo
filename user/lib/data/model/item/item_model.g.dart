// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => _ItemModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  nameAr: json['name_ar'] as String?,
  desc: json['desc'] as String?,
  descAr: json['desc_ar'] as String?,
  image: json['image'] as String?,
  count: (json['count'] as num?)?.toInt(),
  active: (json['active'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  discount: (json['discount'] as num?)?.toInt(),
  categoryId: (json['category_id'] as num?)?.toInt(),
  deliveryTime: (json['delivery_time'] as num?)?.toInt(),
  discountedPrice: (json['discounted_price'] as num?)?.toDouble(),
  isFavorite: json['is_favorite'] as bool?,
  updatedAt: json['updated_at'] as String?,
  category: json['category'] == null
      ? null
      : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ItemModelToJson(_ItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'desc': instance.desc,
      'desc_ar': instance.descAr,
      'image': instance.image,
      'count': instance.count,
      'active': instance.active,
      'price': instance.price,
      'discount': instance.discount,
      'category_id': instance.categoryId,
      'delivery_time': instance.deliveryTime,
      'discounted_price': instance.discountedPrice,
      'is_favorite': instance.isFavorite,
      'updated_at': instance.updatedAt,
      'category': instance.category,
    };
