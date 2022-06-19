import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/pages/edit_bug.dart';
import 'package:bug_tracker_fschmtz/util/utils_functions.dart';
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
      title: Text(
        widget.bug.description,
        maxLines: 3,
      ),
      subtitle: Text(
        widget.bug.applicationName,
      ),
      trailing: Icon(Icons.flag_outlined,
          size: 25, color: widget.bug.getBugPriorityColor()),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditBug(bug: widget.bug),
            )).then((v) => widget.refreshHome());
      },
    );
  }
}
