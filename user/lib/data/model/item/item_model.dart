import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend_user/data/model/category/category_model.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
abstract class ItemModel with _$ItemModel {
  const ItemModel._();

  @JsonSerializable(
    fieldRename: FieldRename.snake,
  ) // يتكفل بتحويل isFavorite إلى is_favorite تلقائياً!
  const factory ItemModel({
    int? id,
    String? name,
    String? nameAr,
    String? desc,
    String? descAr,
    String? image,
    int? count,
    int? active,
    double? price,
    int? discount,
    int? categoryId,
    int? deliveryTime,
    double? discountedPrice,
    bool? isFavorite,
    String? updatedAt,
    CategoryModel? category,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
