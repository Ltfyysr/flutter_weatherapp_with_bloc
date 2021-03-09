import 'dart:convert';

import 'package:flutter_weatherapp_with_bloc/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com/";
  final http.Client httpClient = http.Client();

  Future<int> getLocationID(String sehirAdi) async {
    final sehirURL = baseUrl + "api/location/search/?query=" + sehirAdi;
    final gelenCevap = await httpClient.get(sehirURL);

    if (gelenCevap.statusCode != 200) {
      throw Exception("Veri Getirilemedi");
    }

    final gelenCevapJSON = (jsonDecode(gelenCevap.body))
        as List; //json a dönderdiğim veri aslında bir liste
    return gelenCevapJSON[0][
        "woeid"]; //ve geriye gelenCevapJSON listesinin 0. elemanının içinde bulunan woeid i dönder.
  }

  Future<Weather> getWeather(int sehirID) async {
    final havaDurumuURL = baseUrl + "/api/location/$sehirID";
    final havaDurumuGelenCevap = await httpClient.get(havaDurumuURL);
    if (havaDurumuGelenCevap.statusCode != 200) {
      throw Exception("Hava durumu Getirilemedi");
    }

    final havaDurumuCevapJSON = jsonDecode(havaDurumuGelenCevap
        .body); //body dediğimizde bütün bu json ağacı bana varilmiş oluyor.
    return Weather.fromJson(havaDurumuCevapJSON);
  }
}
