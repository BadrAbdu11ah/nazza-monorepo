import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CategoryModel({
    int? id,
    String? name,
    String? nameAr,
    String? description,
    String? image,
    String? datetime,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
