import 'package:get_it/get_it.dart';
import 'package:past_papers/core/services/Api.dart';
import 'package:past_papers/core/services/CloudService.dart';
import 'package:past_papers/core/services/DatabaseService.dart';
import 'package:past_papers/core/services/NavigationService.dart';
import 'package:past_papers/core/services/TestApi.dart';
import 'package:past_papers/core/widgets_view_models.dart/McqViewModel.dart';
import 'package:uuid/uuid.dart';

GetIt locator = GetIt.instance;
var uuid = Uuid();

void setupLocator() async {
  //services
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => CloudService());
  locator.registerLazySingleton<Api>(() => TestApi());
  locator.registerLazySingleton(() => NavigationService());

  //view models factories
  locator.registerFactory(() => McqViewModel());
}

String getGuid() {
  return uuid.v4();
}

bool isUserVersion = false;
bool enableAdminVersion = true;
