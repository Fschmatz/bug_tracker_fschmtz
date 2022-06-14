import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/pages/editBug.dart';
import 'package:flutter/material.dart';

class BugTile extends StatefulWidget {
  @override
  _BugTileState createState() => _BugTileState();

  int? index;
  Bug bug;
  Function() refreshHome;
  Function() refreshDoneBugs;

  BugTile(
      {Key? key,
      this.index,
      required this.bug,
      required this.refreshHome,
      required this.refreshDoneBugs})
      : super(key: key);
}

class _BugTileState extends State<BugTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 20,
      title: Text(
        widget.bug.description,
      ),
      subtitle: Text(
        widget.bug.applicationName,
      ),
      leading: Icon(Icons.flag_outlined,
          size: 25, color: Color(int.parse(widget.bug.color.substring(6, 16)))),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditBug(bug: widget.bug),
            ))
            .then(
                (v) => widget.refreshHome());
      },
    );
  }
}
