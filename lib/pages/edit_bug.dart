import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditBug extends StatefulWidget {
  @override
  _EditBugState createState() => _EditBugState();

  Bug bug;

  EditBug({Key? key, required this.bug}) : super(key: key);
}

class _EditBugState extends State<EditBug> {

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


  @override
  void initState() {
    controllerApplicationName.text = widget.bug.applicationName;
    controllerDescription.text = widget.bug.description;
    controllerCorrectOutcome.text = widget.bug.correctOutcome;
    controllerHowWasSolved.text = widget.bug.howWasSolved!;
    controllerNote.text = widget.bug.note!;
    changePriority(widget.bug.priority);
    super.initState();
  }

  void _updateBug() async {
    final dbBug = BugDao.instance;
    Map<String, dynamic> row = {
      BugDao.columnIdBug: widget.bug.idBug,
      BugDao.columnDescription: controllerDescription.text,
      BugDao.columnApplicationName: controllerApplicationName.text,
      BugDao.columnState: widget.bug.state,
      BugDao.columnPriority: priorityValue,
      BugDao.columnCorrectOutcome: controllerCorrectOutcome.text,
      BugDao.columnHowWasSolved: controllerHowWasSolved.text,
      BugDao.columnNote: controllerNote.text,
    };
    final update = await dbBug.update(row);
  }

  void changeBugState() async {
    final dbBug = BugDao.instance;
    Map<String, dynamic> row = {
      BugDao.columnIdBug: widget.bug.idBug,
      BugDao.columnState: widget.bug.state == 0 ? 1 : 0,
    };
    final update = await dbBug.update(row);
  }

  void deleteBug() async {
    final dbBug = BugDao.instance;
    final delete = await dbBug.delete(widget.bug.idBug);
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


  showAlertDialogOkDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm",
          ),
          content: const Text(
            "Delete ?",
          ),
          actions: [
            TextButton(
              child: const Text(
                "Yes",
              ),
              onPressed: () {
                deleteBug();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {
                showAlertDialogOkDelete(context);
              },
            ),
            IconButton(
              icon: widget.bug.state == 0
                  ? Icon(Icons.archive_outlined)
                  : Icon(Icons.unarchive_outlined),
              onPressed: () {
                changeBugState();
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.save_outlined),
              onPressed: () {
                if (validateTextFields()) {
                  _updateBug();
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
