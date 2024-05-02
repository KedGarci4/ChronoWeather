import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';


class TimerPage extends StatefulWidget  {
  TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
   
}

class _TimerPageState extends State<TimerPage>with TickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  late AnimationController controller;
  bool isPlaying = false;

  String get countText{
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed?
    '${(controller.duration!.inHours % 60).toString().padLeft(2,'0')
    }:${(controller.duration!.inMinutes % 60).toString().padLeft(2,'0')
    }:${(controller.duration!.inSeconds % 60).toString().padLeft(2,'0')}':
    '${(count.inHours % 60).toString().padLeft(2,'0')
    }:${(count.inMinutes % 60).toString().padLeft(2,'0')
    }:${(count.inSeconds % 60).toString().padLeft(2,'0')}';
  }


  double progress=1.0;
  void notifySound(){
    if(countText=='00:00:00'){
      FlutterRingtonePlayer().playNotification();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(vsync: this, duration: const Duration(seconds:60));
    controller.addListener(() {
      notifySound();
      if(controller.isAnimating){
        setState(() {
          progress = controller.value;
        });
      }else{
        setState(() {
          progress=1.0;
          isPlaying=false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(color: Colors.grey[850]),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[900],
                      color: Colors.yellow,
                      value: progress,
                      strokeWidth: 6,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.isDismissed){
                        showModalBottomSheet(
                        context: context, 
                        builder: (context) => SizedBox(
                          height: 300,
                          child: CupertinoTimerPicker(
                            initialTimerDuration: controller.duration!,
                            onTimerDurationChanged: (time){
                            setState(() {
                              controller.duration=time;
                            });
                          })
                        ),
                      );

                      }

                    },
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (controller, child)=>
                      Text(
                        countText,
                        style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                        ), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                onPressed:() {
                  if (controller.isAnimating){
                    controller.stop();
                    setState(() {
                      isPlaying = false;
                    });
                  }else{
                    controller.reverse(from: controller.value==0?1.0:controller.value);
                    setState(() {
                      isPlaying = true;
                    });
                  }
                  
                },
                backgroundColor: Colors.yellow,
                shape: const CircleBorder(),
                child: isPlaying == true ? const Icon(Icons.pause, color: Colors.red,) : const Icon(Icons.play_arrow, color: Colors.red,),
                ),
                const SizedBox(width: 100,),
                FloatingActionButton(
                onPressed:() {
                  controller.reset() ;
                  setState(() {
                    isPlaying = false;
                  });

                },
                backgroundColor: Colors.yellow,
                shape: const CircleBorder(),
                child: const Icon(Icons.stop_rounded, color: Colors.red,),
                ),
              ],
              ),
            ),
        ],
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}