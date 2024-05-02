import 'package:flutter/material.dart';
import 'package:chronoweather/models/weather_model.dart';
import 'package:chronoweather/services/weather_service.dart';
import 'package:lottie/lottie.dart';


class WeatherPage extends StatefulWidget {
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

//configurar el api key
class _WeatherPageState extends State<WeatherPage> with AutomaticKeepAliveClientMixin{
  final _servicioClima = WeatherService("7e17db8e85198497700dc33ddadd3080");
  Weather? _clima;

  _encuentraClima() async{
    String ciudadActual = await _servicioClima.getCurrentCity();
    try{
      final weather = await _servicioClima.getWeather(ciudadActual);
      setState(() {
        _clima = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

//Animaciones
String getWeatherAnimation(String? actualCondition){
  if (actualCondition == null ) return "assets/sunny.json";

  switch(actualCondition.toLowerCase()){
    case "clouds":
    case "mist":
    case "smoke":
    case "haze":
    case "dust":
    case "fog":
      return "assets/clouds.json";
    case "rain":
    case "drizzle":
    case "shower rain":
      return "assets/partial clouds.json";
    case "thunderstorm":
      return "assets/storm.json";
    case "clear":
      return "assets/sunny.json";
    default:
      return "assets/sunny.json";
  }
}

  @override
  void initState() {
    super.initState();

    _encuentraClima() ;

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(color:Colors.grey[850]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Agrega el ícono
          const Icon(Icons.location_pin,color: Colors.white),
          const Padding(padding: EdgeInsets.all(8.0)),

          //Localiza la ciudad
          Text(_clima?.cityName?? "Cargando ciudad...", 
          style:const TextStyle(
            color: Colors.white,
            fontSize: 40, 
            fontStyle: FontStyle.italic, 
            fontWeight: FontWeight.bold)
            ),
            const Padding(padding: EdgeInsets.all(50.0)),
            
          //Agrega animación
          Lottie.asset(getWeatherAnimation(_clima?.actualCondition)),

          const Padding(padding: EdgeInsets.all(50.0)),

          //muestra la temperatura
          Text("${_clima?.temperature.round().toString()}°C",
          style:const TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold)
            ),

            //Muestra la condición actual
          Text(_clima?.actualCondition ?? "",
          style:const TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold)
            ),
        ]
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}