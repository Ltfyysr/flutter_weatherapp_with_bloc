import 'package:equatable/equatable.dart';
import 'package:flutter_weatherapp_with_bloc/models/weather.dart';
import 'package:meta/meta.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class InitialWeatherState extends WeatherState {
  //ilk durumda ise
  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  WeatherLoadedState({@required this.weather}) : super([weather]);
}

class WeatherErrorState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
