import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/pages/editBug.dart';
import 'package:flutter/material.dart';

class BugDone extends StatefulWidget {
  @override
  _BugDoneState createState() => _BugDoneState();

  int index;
  Bug bug;
  Function() refreshHome;
  Function() refreshDoneBugs;

  BugDone(
      {Key key, this.index, this.bug, this.refreshHome, this.refreshDoneBugs})
      : super(key: key);
}

class _BugDoneState extends State<BugDone> {
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
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
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              EditBug(bug:  widget.bug),
                                          fullscreenDialog: true,
                                        )).then((value) => widget.refreshDoneBugs());
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
                              title: Text(
                                widget.bug.correctOutcome,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListTile(
                              leading: Icon(Icons.article_outlined, size: 22),
                              title: Text(
                                widget.bug.errorDescription,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.bug.note.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ListTile(
                                leading:
                                    Icon(Icons.text_snippet_outlined, size: 22),
                                title: Text(
                                  widget.bug.note,
                                  style: TextStyle(fontSize: 16),
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
                              margin: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                //leading: Icon(Icons.done_outline, size: 22),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.remove_done),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      "Set Not Done",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
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
          widget.bug.errorDescription,
          style: TextStyle(fontSize: 14.5),
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
