import 'package:frontend_user/api_endpoints.dart';
import 'package:frontend_user/core/services/api_service.dart';
import 'package:frontend_user/core/services/app_service.dart';
import 'package:frontend_user/core/services/location_service.dart';

import 'package:frontend_user/features/search/data/search_data.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl تعني Service Locator

Future<void> initGetIt() async {
  // 1. Services (الأدوات الأساسية)
  sl.registerLazySingleton(() => ApiService(baseUrl: ApiEndpoints.baseUrl));
  sl.registerLazySingleton(() => AppService());

  // 2. Data Sources / Repositories

  sl.registerLazySingleton(() => SearchData(sl<ApiService>()));

  sl.registerLazySingleton(() => LocationServiceImpl());

  // 3. Blocs

  // Auth Blocs

  // Forget Password Blocs

  // Home

  // Items

  // address

  //checkout

  // order
}
