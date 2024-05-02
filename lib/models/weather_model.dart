class Weather{
  final String cityName;
  final double temperature;
  final String actualCondition;

  Weather({
    required this.cityName, 
    required this.temperature, 
    required this.actualCondition});

    factory Weather.fromJson(Map<String, dynamic> json){
      return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        actualCondition: json['weather'][0]['main']
      );
    }
    
}