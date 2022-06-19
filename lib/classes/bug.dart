import 'dart:ui';

class Bug{

  int idBug;
  String applicationName;
  String description;
  String correctOutcome;
  int state;
  int priority;
  String? howWasSolved;
  String? note;

  Bug({required this.idBug,
      required this.description,
      required this.applicationName,
      required this.state,
      required this.priority,
      required this.correctOutcome,
      this.howWasSolved,
      this.note});

  Color getBugPriorityColor(){
    if(this.priority == 1){
      return Color(0xFFFF6E40);
    }
    if(this.priority == 2){
      return Color(0xFFFC5757);
    }
    return Color(0xFFFFD600);
  }

}
