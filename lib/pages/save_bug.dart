import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveBug extends StatefulWidget {
  @override
  _SaveBugState createState() => _SaveBugState();
}

class _SaveBugState extends State<SaveBug> {
  final dbBug = BugDao.instance;
  int priorityValue = 0;
  List<Color> priorityColors = [
    Color(0xFFFFCC00),
    Color(0xFFFF7134),
    Color(0xFFFD3C3C),
  ];
  Icon iconSelected = Icon(
    Icons.done,
    size: 20,
    color: Colors.black87,
  );

  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerCorrectOutcome = TextEditingController();
  TextEditingController controllerApplicationName = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  TextEditingController controllerHowWasSolved = TextEditingController();
  bool _validApplicationName = true;
  bool _validDescription = true;
  bool _validOutcome = true;

  void _saveBug() async {
    Map<String, dynamic> row = {
      BugDao.columnDescription: controllerDescription.text,
      BugDao.columnApplicationName: controllerApplicationName.text,
      BugDao.columnState: 0,
      BugDao.columnPriority: priorityValue,
      BugDao.columnCorrectOutcome: controllerCorrectOutcome.text,
      BugDao.columnHowWasSolved: controllerHowWasSolved.text,
      BugDao.columnNote: controllerNote.text,
    };
    final id = await dbBug.insert(row);
  }

  bool validateTextFields() {
    bool ok = true;
    if (controllerApplicationName.text.isEmpty) {
      ok = false;
      _validApplicationName = false;
    }
    if (controllerDescription.text.isEmpty) {
      ok = false;
      _validDescription = false;
    }
    if (controllerCorrectOutcome.text.isEmpty) {
      ok = false;
      _validOutcome = false;
    }
    return ok;
  }

  void changePriority(int priority){
    setState(() {
      priorityValue = priority;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Bug"),
          actions: [
            IconButton(
              icon: Icon(Icons.save_outlined),
              onPressed: () {
                if (validateTextFields()) {
                  _saveBug();
                  Navigator.of(context).pop();
                } else {
                  setState(() {});
                }
              },
            ),
          ],
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: null,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerApplicationName,
              decoration: InputDecoration(
                labelText: "Application Name",
                helperText: "* Required",
                counterText: "",
                errorText: (_validApplicationName) ? null : "Application Name is empty",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: null,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerDescription,
              decoration: InputDecoration(
                labelText: "Description",
                helperText: "* Required",
                counterText: "",
                errorText: (_validDescription) ? null : "Description is empty",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: null,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerCorrectOutcome,
              decoration: InputDecoration(
                labelText: "Correct Outcome",
                helperText: "* Required",
                counterText: "",
                errorText: (_validOutcome) ? null : "Correct Outcome is empty",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.flag_outlined,
                      color: Theme.of(context).hintColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Priority",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).hintColor,
                      ),
                    )
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      minWidth: 55,
                      height: 35,
                      child: priorityValue == 2
                          ? iconSelected
                          : null,
                      shape: CircleBorder(),
                      elevation: 0,
                      color: priorityColors[2],
                      onPressed: () {
                        changePriority(2);
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MaterialButton(
                      minWidth: 55,
                      height: 35,
                      child: priorityValue == 1
                          ? iconSelected
                          : null,
                      shape: CircleBorder(),
                      elevation: 0,
                      color: priorityColors[1],
                      onPressed: () {
                        changePriority(1);
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MaterialButton(
                      minWidth: 55,
                      height: 35,
                      child: priorityValue == 0
                          ? iconSelected
                          : null,
                      shape: CircleBorder(),
                      elevation: 0,
                      color: priorityColors[0],
                      onPressed: () {
                        changePriority(0);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: null,
              maxLength: 2000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerHowWasSolved,
              decoration: InputDecoration(
                labelText: "How was solved",
                counterText: "",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: TextField(
              minLines: 1,
              maxLines: null,
              maxLength: 2000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: controllerNote,
              decoration: InputDecoration(
                labelText: "Note",
                counterText: "",
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ]));
  }
}
