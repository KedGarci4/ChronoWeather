import 'package:chronoweather/pages/alarm_page.dart';
import 'package:chronoweather/pages/taskspage.dart';
import 'package:chronoweather/pages/timerpage.dart';
import 'package:chronoweather/pages/chronopage.dart';
import 'package:chronoweather/pages/weather_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.currentIndex=0});

int currentIndex;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final PageController _pageController = PageController();

  final List<Widget> _children = [
      
      TaskPage(),
      const AlarmPage(),
      WeatherPage(),
      const ChronoPage(),
      TimerPage(),  
      
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor:Colors.grey[850],
        title: const Text('ChronoWeather',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color:Colors.white)
          ),
      ),*/
      body: PageView.builder(
        controller: _pageController,
        itemCount: _children.length,
        onPageChanged: (value) {
          setState(() {
            widget.currentIndex=value;
          });
        },
        itemBuilder: (context, index) {
          return _children[index];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[850],
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items:const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 48, 48, 48),
            icon: Icon(Icons.task_alt_outlined),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 48, 48, 48),
            icon: Icon(Icons.alarm),
            label: 'Alarma',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 48, 48, 48),
            icon: Icon(Icons.wb_sunny),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 48, 48, 48),
            icon: Icon(Icons.timer),
            label: 'Cronómetro',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 48, 48, 48),
            icon: Icon(Icons.av_timer_outlined),
            label: 'Temporizador',
          ),
        ],
      ),
    );
  }
}
