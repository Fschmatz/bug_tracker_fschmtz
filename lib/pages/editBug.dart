import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditBug extends StatefulWidget {
  @override
  _EditBugState createState() => _EditBugState();

  Bug bug;

  EditBug({Key key, this.bug}) : super(key: key);
}

class _EditBugState extends State<EditBug> {
  Color selectedColor = Color(0xFFFFD600);
  int state = 0;

  TextEditingController customControllerDescription = TextEditingController();
  TextEditingController customControllerCorrectOutcome =
      TextEditingController();
  TextEditingController customControllerErrorDescription =
      TextEditingController();
  TextEditingController customControllerNote = TextEditingController();

  bool isSelectedRed = false;
  bool isSelectedOrange = false;
  bool isSelectedYellow = false;
  Icon iconSelected = Icon(
    Icons.done,
    size: 20,
  );

  @override
  void initState() {
    customControllerDescription.text = widget.bug.description;
    customControllerCorrectOutcome.text = widget.bug.correctOutcome;
    customControllerErrorDescription.text = widget.bug.errorDescription;
    customControllerNote.text = widget.bug.note;
    state = widget.bug.state;
    print(selectedColor.toString() +
        '  ' +
        Color(int.parse(widget.bug.color.substring(6, 16))).toString());
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
      BugDao.columnDescription: customControllerDescription.text,
      BugDao.columnState: state,
      BugDao.columnColor: selectedColor.toString(),
      BugDao.columnCorrectOutcome: customControllerCorrectOutcome.text,
      BugDao.columnErrorDescription: customControllerErrorDescription.text,
      BugDao.columnNote: customControllerNote.text,
    };
    final update = await dbBug.update(row);
  }

  String checkProblems() {
    String errors = "";
    if (customControllerDescription.text.isEmpty) {
      errors += "Insert Description\n";
    }
    if (customControllerCorrectOutcome.text.isEmpty) {
      errors += "Insert Correct Outcome\n";
    }
    if (customControllerErrorDescription.text.isEmpty) {
      errors += "Insert Error Description\n";
    }
    return errors;
  }

  showAlertDialogErrors(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
        style: TextStyle(
          fontSize: 18,
        ),
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
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkProblems().isEmpty) {
                    _updateBug();
                    Navigator.of(context).pop();
                  } else {
                    showAlertDialogErrors(context);
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 100,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerDescription,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.article_outlined, size: 20),
                        hintText: "Description",
                        helperText: "* Required",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 12,
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
                              fontSize: 17,
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
                                    size: 24,
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
                                    size: 24,
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
                                    size: 24,
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
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 100,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerCorrectOutcome,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.article_outlined, size: 20),
                        hintText: "Correct Outcome",
                        helperText: "* Required",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 100,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerErrorDescription,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.article_outlined, size: 20),
                        hintText: "Error Description",
                        helperText: "* Required",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 500,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerNote,
                    //autofocus: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.text_snippet_outlined, size: 20),
                        hintText: "Note",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(10.0))),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ])));
  }
}
