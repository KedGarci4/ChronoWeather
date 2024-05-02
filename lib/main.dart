import "package:chronoweather/pages/homepage.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import "package:hive_flutter/hive_flutter.dart";



/*FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
FlutterLocalNotificationsPlugin();*/


void main()async{
  await Hive.initFlutter();
  var box = await Hive.openBox("mybox");
  /*WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();*/
    //Bloqueando la rotación
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChronoWeather',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
