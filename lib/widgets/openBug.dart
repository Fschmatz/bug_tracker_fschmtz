import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/pages/editBug.dart';
import 'package:flutter/material.dart';

class OpenBug extends StatefulWidget {
  @override
  _OpenBugState createState() => _OpenBugState();

  int index;
  Bug bug;
  Function() refreshHome;
  Function() refreshDoneBugs;

  OpenBug(
      {Key key, this.index, this.bug, this.refreshHome, this.refreshDoneBugs})
      : super(key: key);
}

class _OpenBugState extends State<OpenBug> {
  void changeBugState(int id, int state) async {
    final dbBug = BugDao.instance;
    Map<String, dynamic> row = {
      BugDao.columnIdBug: id,
      BugDao.columnState: state,
    };
    final update = await dbBug.update(row);
  }

  void bottomMenuShowItem() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Color(
                                  int.parse(widget.bug.color.substring(6, 16))),
                              radius: 15,
                            ),
                            title: Text(
                              widget.bug.description,
                              style: TextStyle(
                                  fontSize: 16.5, fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EditBug(bug: widget.bug),
                                      fullscreenDialog: true,
                                    )).then((value) => widget.refreshHome());
                              },
                              icon: Icon(Icons.edit_outlined, size: 22),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListTile(
                              leading: Icon(Icons.article_outlined, size: 22),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Application Name",
                                    style: TextStyle(fontSize: 14,color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color
                                        .withOpacity(0.7),),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.bug.applicationName,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListTile(
                              leading: Icon(Icons.article_outlined, size: 22),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Correct Outcome",
                                    style: TextStyle(fontSize: 14,color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color
                                        .withOpacity(0.7),),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.bug.correctOutcome,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.bug.note.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListTile(
                                leading:
                                    Icon(Icons.text_snippet_outlined, size: 22),
                                title:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Note",
                                      style: TextStyle(fontSize: 14,color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color
                                          .withOpacity(0.7),),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      widget.bug.note,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Card(
                              color: Theme.of(context).accentColor,
                              margin: const EdgeInsets.fromLTRB(140, 0, 140, 0),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                title:  Text(
                                  "Close",textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                onTap: () {
                                  changeBugState(widget.bug.idBug, 1);
                                  widget.refreshHome();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ])
                      ]),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          widget.bug.description,
          style: TextStyle(fontSize: 16),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          widget.bug.applicationName,
          style: TextStyle(fontSize: 14,color: Theme.of(context)
              .textTheme
              .headline6
              .color
              .withOpacity(0.7),),
        ),
      ),
      leading: CircleAvatar(
          backgroundColor:
              Color(int.parse(widget.bug.color.substring(6, 16)))),
      onTap: () {
        bottomMenuShowItem();
      },
    );
  }
}
