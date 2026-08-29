import 'package:frontend_user/api_endpoints.dart';
import 'package:frontend_user/core/class/failure.dart';
import 'package:frontend_user/core/services/api_service.dart';
import 'package:frontend_user/data/model/item/item_model.dart';
import 'package:fpdart/fpdart.dart';

class SearchData {
  final ApiService api;
  SearchData(this.api);

  // البحث عن المنتجات
  Future<Either<Failure, List<ItemModel>>> searchResults(String search) async {
    var response = await api.post(ApiEndpoints.searchItems, {"search": search});

    return response.fold((Failure failure) => Left(failure), (
      Map<String, dynamic> data,
    ) {
      final List rawData = data['data'] ?? [];

      final List<ItemModel> itemsList = rawData
          .map<ItemModel>((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(itemsList);
    });
  }
}
