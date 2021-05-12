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

  TextEditingController customControllerDescription = TextEditingController();
  TextEditingController customControllerCorrectOutcome = TextEditingController();
  TextEditingController customControllerNote = TextEditingController();
  TextEditingController customControllerApplicationName = TextEditingController();


  bool isSelectedRed = false;
  bool isSelectedOrange = false;
  bool isSelectedYellow = false;
  Icon iconSelected = Icon(Icons.done,size: 20,);


  @override
  void initState() {
    isSelectedYellow = true;
    super.initState();
  }


  void _saveBug() async {
    Map<String, dynamic> row = {
      BugDao.columnDescription: customControllerDescription.text,
      BugDao.columnApplicationName: customControllerApplicationName.text,
      BugDao.columnState: 0,
      BugDao.columnColor : selectedColor.toString(),
      BugDao.columnCorrectOutcome: customControllerCorrectOutcome.text,
      BugDao.columnNote: customControllerNote.text,
    };
    final id = await dbBug.insert(row);
    print('id = $id');
  }

  String checkProblems() {
    String errors = "";
    if (customControllerApplicationName.text.isEmpty) {
      errors += "Insert Application Name\n";
    }
    if (customControllerDescription.text.isEmpty) {
      errors += "Insert Description\n";
    }
    if (customControllerCorrectOutcome.text.isEmpty) {
      errors += "Insert Correct Outcome\n";
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
                    _saveBug();
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
                    maxLength: 150,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: customControllerApplicationName,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.article_outlined, size: 20),
                        hintText: "Application Name",
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
                            borderRadius: BorderRadius.circular(10.0))
                    ),
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
                    maxLength: 150,
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
                            borderRadius: BorderRadius.circular(10.0))
                    ),
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
                          child:Row(
                            children: [
                              SizedBox(width: 12,),
                              Icon(Icons.flag_outlined,color: Theme.of(context).hintColor,),
                              SizedBox(width: 15,),
                              Text("Priority",style:TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).hintColor,
                              ),)
                            ],
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            minWidth: 20,
                            height: 35,
                            child: isSelectedRed ? Icon(Icons.check,size: 24,color: Colors.black87,) : SizedBox.shrink(),
                            shape: CircleBorder(),
                            elevation: 1,
                            color: Color(0xFFFF5252),
                            onPressed: () {
                              setState(()  {
                                isSelectedRed = true;
                                isSelectedOrange = false;
                                isSelectedYellow = false;
                              });
                              selectedColor = Color(0xFFFF5252);
                            },
                          ),
                          const SizedBox(width: 15,),
                          MaterialButton(
                            minWidth: 20,
                            height: 35,
                            child: isSelectedOrange ? Icon(Icons.check,size: 24,color: Colors.black87,) : SizedBox.shrink(),
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
                          const SizedBox(width: 15,),
                          MaterialButton(
                            minWidth: 20,
                            height: 35,
                            child: isSelectedYellow ? Icon(Icons.check,size: 24,color: Colors.black87,) : SizedBox.shrink(),
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
                    height: 25,
                  ),
                  TextField(
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 150,
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
                            borderRadius: BorderRadius.circular(10.0))
                    ),
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
                            borderRadius: BorderRadius.circular(10.0))
                    ),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]
            )
        )
    );

  }
}
