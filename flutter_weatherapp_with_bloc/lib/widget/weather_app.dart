import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/weather/bloc.dart';
import 'package:flutter_weatherapp_with_bloc/weather/tema/bloc.dart';
import 'package:flutter_weatherapp_with_bloc/widget/hava_durumu_resim.dart';
import 'package:flutter_weatherapp_with_bloc/widget/location.dart';
import 'package:flutter_weatherapp_with_bloc/widget/max_min_sicaklik.dart';
import 'package:flutter_weatherapp_with_bloc/widget/sehir_sec.dart';
import 'package:flutter_weatherapp_with_bloc/widget/son_guncelleme.dart';

import 'gecisli_arkaplan_renk.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "Ankara";
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    final _weatherBloc =
        BlocProvider.of<WeatherBloc>(context); //bloc yapımızı aldık
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                kullanicininSectigiSehir = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SehirSecWidget()));
                //debugPrint("Seçilen şehir : " + kullanicininSectigiSehir);
                if (kullanicininSectigiSehir != null) {
                  _weatherBloc.dispatch(
                      FetchWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                }
              }),
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          // ignore: missing_return
          builder: (context, WeatherState state) {
            if (state is InitialWeatherState) {
              return Center(
                child: Text("Şehir Seçiniz"),
              );
            }
            if (state is WeatherLoadingState) {
              //hava durumu getirilme state inde ise
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadedState) {
              //internetten getirilmiş ise
              final getirilenWeather = state.weather;
              final _havaDurumKisaltma =
                  getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
              kullanicininSectigiSehir = getirilenWeather.title;
              BlocProvider.of<TemaBloc>(context).dispatch(
                  TemaDegistirEvent(havaDurumuKisaltmasi: _havaDurumKisaltma));
              _refreshCompleter
                  .complete(); //refresh ederken yükleme olayı bitince durdurur.
              _refreshCompleter = Completer(); //sıfırlar.
              return BlocBuilder(
                bloc: BlocProvider.of<TemaBloc>(context),
                builder: (context, TemaState temaState) => GecisliRenkContainer(
                  renk: (temaState as UygulamaTemasi).renk,
                  child: RefreshIndicator(
                    onRefresh: () {
                      _weatherBloc.dispatch(RefreshWeatherEvent(
                          sehirAdi: kullanicininSectigiSehir));
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: LocationWidget(
                            secilenSehir: getirilenWeather.title,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: SonGuncellemeWidget()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: HavaDurumuResimWidget()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: MaxveMinSicaklikWidget()),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is WeatherErrorState) {
              return Center(
                child: Text("Hata Oluştu"),
              );
            }
          },
        ),
      ),
    );
  }
}
