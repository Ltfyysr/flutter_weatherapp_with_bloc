import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/locator.dart';
import 'package:flutter_weatherapp_with_bloc/weather/bloc.dart';
import 'package:flutter_weatherapp_with_bloc/weather/tema/bloc.dart';
import 'package:flutter_weatherapp_with_bloc/widget/weather_app.dart';

void main() {
  setupLocator();
  runApp(
    BlocProvider<TemaBloc>(
        builder: (context) => TemaBloc(),
        child:
            MyApp()), //temabloc myapp ve altındaki tüm widgetlarda geçerli olacak
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(
          context), //en yukarda tanımladığımız bloc u elde ettik.
      builder: (context, TemaState state) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false, //ekrandaki debug yazısı kalkar
        theme: (state as UygulamaTemasi).tema,
        home: BlocProvider<WeatherBloc>(
            builder: (context) => WeatherBloc(), child: WeatherApp()),
      ),
    );
  }
}
