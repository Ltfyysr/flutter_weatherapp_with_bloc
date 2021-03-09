import 'package:flutter_weatherapp_with_bloc/data/weather_api_client.dart';
import 'package:get_it/get_it.dart';

import 'data/weather_repository.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerLazySingleton(() =>
      WeatherRepository()); //lazy ilk defa istek geldiğinde üretir.Bir kere üretiyor ve sürekli aynı şeyi kullanıyor.
  locator.registerLazySingleton(() => WeatherApiClient());
  //locator.registerFactory(() =>null);
//her istekte bulunulduğunda her seferinde yeni bir nesne üretir.
}
