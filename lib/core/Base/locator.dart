import 'package:get_it/get_it.dart';
import 'package:past_papers/core/services/NavigationService.dart';
import 'package:past_papers/core/view_models/CourseViewModel.dart';

GetIt locator = GetIt.instance();

void setupLocator() {
  locator.registerLazySingleton(() => CourseViewModel());
  locator.registerLazySingleton(() => NavigationService());
}