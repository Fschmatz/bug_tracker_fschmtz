class Bug{

  int idBug;
  String description;
  String applicationName;
  int state;
  String color;
  String correctOutcome;
  String? note;

  Bug({required this.idBug,
      required this.description,
      required this.applicationName,
      required this.state,
      required this.color,
      required this.correctOutcome,
      this.note});
}
