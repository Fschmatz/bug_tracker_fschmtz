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
  Color selectedColor = Color(0xFFFFD600);
  int state = 0;

  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerCorrectOutcome = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  TextEditingController controllerApplicationName = TextEditingController();

  bool isSelectedRed = false;
  bool isSelectedOrange = false;
  bool isSelectedYellow = false;
  Icon iconSelected = Icon(
    Icons.done,
    size: 20,
  );

  @override
  void initState() {
    controllerDescription.text = widget.bug.description;
    controllerCorrectOutcome.text = widget.bug.correctOutcome;
    controllerNote.text = widget.bug.note!;
    controllerApplicationName.text = widget.bug.applicationName;
    state = widget.bug.state;
    selectedColor = Color(int.parse(widget.bug.color.substring(6, 16)));
    if (Color(int.parse(widget.bug.color.substring(6, 16)))
        .toString()
        .compareTo(Color(0xFFFFD600).toString())
        .isEven) {
      isSelectedYellow = true;
    }
    if (Color(int.parse(widget.bug.color.substring(6, 16)))
        .toString()
        .compareTo(Color(0xFFFF5252).toString())
        .isEven) {
      isSelectedRed = true;
    }
    if (Color(int.parse(widget.bug.color.substring(6, 16)))
        .toString()
        .compareTo(Color(0xFFFF6E40).toString())
        .isEven) {
      isSelectedOrange = true;
    }
    super.initState();
  }

  void _updateBug() async {
    final dbBug = BugDao.instance;
    Map<String, dynamic> row = {
      BugDao.columnIdBug: widget.bug.idBug,
      BugDao.columnDescription: controllerDescription.text,
      BugDao.columnApplicationName: controllerApplicationName.text,
      BugDao.columnState: state,
      BugDao.columnColor: selectedColor.toString(),
      BugDao.columnCorrectOutcome: controllerCorrectOutcome.text,
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
          //title: Text("Edit Bug"),
          elevation: 0,
          actions: [
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
              icon: Icon(Icons.delete_outline_outlined),
              onPressed: () {
                deleteBug();
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.save_outlined),
              onPressed: () {
                if (checkProblems().isEmpty) {
                  _updateBug();
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
              maxLines: null,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
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
              maxLines: null,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
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
              maxLines: null,
              maxLength: 500,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
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
                      minWidth: 55,
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
                      color: Color(0xFFFC5757),
                      onPressed: () {
                        setState(() {
                          isSelectedRed = true;
                          isSelectedOrange = false;
                          isSelectedYellow = false;
                        });
                        selectedColor = Color(0xFFFC5757);
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MaterialButton(
                      minWidth: 55,
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
                      minWidth: 55,
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
