import 'package:hive/hive.dart';

class taskDatabase {
  List taskList = [];
  late final Box mybox;

  taskDatabase() {
    _openBox();
  }

  void _openBox() async {
    await Hive.openBox("mybox");
    mybox = Hive.box("mybox");
  }

  // Initializes the taskList with default tasks including "Ir a clase" and "Hacer ejercicio".
  void dataInicial() {
    taskList = [
      ["Ir a clase", false],
      ["Hacer ejercicio", false],
    ];
  }

  void cargaData(){
    try {
      taskList = mybox.get("taskList");
    } catch (e) {
      // Handle the exception here
      print("Exception while loading data from Hive box: $e");
    }
  }

  void updateData() {
    try {
      mybox.put("taskList", taskList);
    } catch (e) {
      // Handle the exception here
      print("Exception while updating data in Hive box: $e");
    }
  }
}