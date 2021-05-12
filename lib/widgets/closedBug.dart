import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/pages/editBug.dart';
import 'package:flutter/material.dart';

class ClosedBug extends StatefulWidget {
  @override
  _ClosedBugState createState() => _ClosedBugState();

  int index;
  Bug bug;
  Function() refreshHome;
  Function() refreshDoneBugs;

  ClosedBug(
      {Key key, this.index, this.bug, this.refreshHome, this.refreshDoneBugs})
      : super(key: key);
}

class _ClosedBugState extends State<ClosedBug> {
  void deleteBug(int id) async {
    final dbBug = BugDao.instance;
    final delete = await dbBug.delete(id);
  }

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
                            trailing: Wrap(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete_outline_rounded),
                                  onPressed: () {
                                    deleteBug(widget.bug.idBug);
                                    widget.refreshDoneBugs();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  EditBug(bug: widget.bug),
                                              fullscreenDialog: true,
                                            ))
                                        .then((value) =>
                                            widget.refreshDoneBugs());
                                  },
                                  icon: Icon(Icons.edit_outlined, size: 22),
                                ),
                              ],
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
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color
                                          .withOpacity(0.7),
                                    ),
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
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color
                                          .withOpacity(0.7),
                                    ),
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
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Note",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color
                                            .withOpacity(0.7),
                                      ),
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
                                title: Text(
                                  "Open",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                onTap: () {
                                  changeBugState(widget.bug.idBug, 0);
                                  widget.refreshDoneBugs();
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
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(
          widget.bug.description,
          style: TextStyle(fontSize: 16),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          widget.bug.applicationName,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.headline6.color.withOpacity(0.7),
          ),
        ),
      ),
      leading: CircleAvatar(
          backgroundColor: Color(int.parse(widget.bug.color.substring(6, 16)))),
      onTap: () {
        bottomMenuShowItem();
      },
    );
  }
}
