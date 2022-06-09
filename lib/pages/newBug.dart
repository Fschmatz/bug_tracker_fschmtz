import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewBug extends StatefulWidget {
  @override
  _NewBugState createState() => _NewBugState();
}

class _NewBugState extends State<NewBug> {
  final dbBug = BugDao.instance;
  Color selectedColor = Color(0xFFFFD600);

  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerCorrectOutcome =
      TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  TextEditingController controllerApplicationName =
      TextEditingController();

  bool isSelectedRed = false;
  bool isSelectedOrange = false;
  bool isSelectedYellow = false;
  Icon iconSelected = Icon(
    Icons.done,
    size: 20,
  );

  @override
  void initState() {
    isSelectedYellow = true;
    super.initState();
  }

  void _saveBug() async {
    Map<String, dynamic> row = {
      BugDao.columnDescription: controllerDescription.text,
      BugDao.columnApplicationName: controllerApplicationName.text,
      BugDao.columnState: 0,
      BugDao.columnColor: selectedColor.toString(),
      BugDao.columnCorrectOutcome: controllerCorrectOutcome.text,
      BugDao.columnNote: controllerNote.text,
    };
    final id = await dbBug.insert(row);
  }

  String checkProblems() {
    String errors = "";
    if (controllerApplicationName.text.isEmpty) {
      errors += "Insert Application Name\n";
    }
    if (controllerDescription.text.isEmpty) {
      errors += "Insert Description\n";
    }
    if (controllerCorrectOutcome.text.isEmpty) {
      errors += "Insert Correct Outcome\n";
    }
    return errors;
  }

  showAlertDialogErrors(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Ok",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Error",
      ),
      content: Text(
        checkProblems(),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Bug"),
          actions: [
            IconButton(
              icon: Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: () {
                if (checkProblems().isEmpty) {
                  _saveBug();
                  Navigator.of(context).pop();
                } else {
                  showAlertDialogErrors(context);
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
              maxLines: 5,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: controllerApplicationName,
              decoration: InputDecoration(
                labelText: "Application Name",
                helperText: "* Required",
                counterText: "",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: 5,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: controllerDescription,
              decoration: InputDecoration(
                labelText: "Description",
                helperText: "* Required",
                counterText: "",
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              minLines: 1,
              maxLines: 5,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
              controller: controllerCorrectOutcome,
              decoration: InputDecoration(
                labelText: "Correct Outcome",
                helperText: "* Required",
                counterText: "",
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
                      minWidth: 20,
                      height: 35,
                      child: isSelectedRed
                          ? Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.black87,
                      )
                          : SizedBox.shrink(),
                      shape: CircleBorder(),
                      elevation: 1,
                      color: Color(0xFFFF5252),
                      onPressed: () {
                        setState(() {
                          isSelectedRed = true;
                          isSelectedOrange = false;
                          isSelectedYellow = false;
                        });
                        selectedColor = Color(0xFFFF5252);
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MaterialButton(
                      minWidth: 20,
                      height: 35,
                      child: isSelectedOrange
                          ? Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.black87,
                      )
                          : SizedBox.shrink(),
                      shape: CircleBorder(),
                      elevation: 1,
                      color: Color(0xFFFF6E40),
                      onPressed: () {
                        setState(() {
                          isSelectedOrange = true;
                          isSelectedRed = false;
                          isSelectedYellow = false;
                        });
                        selectedColor = Color(0xFFFF6E40);
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MaterialButton(
                      minWidth: 20,
                      height: 35,
                      child: isSelectedYellow
                          ? Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.black87,
                      )
                          : SizedBox.shrink(),
                      shape: CircleBorder(),
                      elevation: 2,
                      color: Color(0xFFFFD600),
                      onPressed: () {
                        setState(() {
                          isSelectedYellow = true;
                          isSelectedRed = false;
                          isSelectedOrange = false;
                        });
                        selectedColor = Color(0xFFFFD600);
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
              maxLines: 5,
              maxLength: 2000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.name,
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
