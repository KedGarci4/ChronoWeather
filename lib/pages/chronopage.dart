import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChronoPage extends StatefulWidget {
  const ChronoPage({super.key});

  @override
  State <ChronoPage> createState() => _ChronoPageState();
}

class _ChronoPageState extends State<ChronoPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Swatch(),
    );
  }
   @override
  bool get wantKeepAlive => true;
}

class Swatch extends StatefulWidget {
  const Swatch({super.key});

  @override
  State<Swatch> createState() => _SwatchState();
}

class _SwatchState extends State<Swatch> with AutomaticKeepAliveClientMixin {

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 300,),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final value = snapshot.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value!, hours: _isHours);
                  return Text(
                  displayTime,
                  style: const TextStyle(
                    color: Colors.white,
                      fontSize: 80, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  startButton(),
                  const SizedBox(
                    width: 10,
                  ),
                  stopButton(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            resetButton(),
          ],
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
  ElevatedButton startButton() {
    return ElevatedButton(
      onPressed: () {
        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      },
      child: const Text('Iniciar', style: TextStyle(color:Colors.black)),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow,
          textStyle:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  ElevatedButton stopButton() {
    return ElevatedButton(
      onPressed: () {
        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      },
      child: const Text('Parar',style: TextStyle(color:Colors.white)),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  ElevatedButton resetButton() {
    return ElevatedButton(
      onPressed: () {
        _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
      },
      child: const Text('Reiniciar',style: TextStyle(color:Colors.white)),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          textStyle:
              const TextStyle(color:Colors.white,fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
  
}