import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/widgets/closedBug.dart';
import 'package:flutter/material.dart';

class ClosedBugsPage extends StatefulWidget {
  @override
  _ClosedBugsPageState createState() => _ClosedBugsPageState();
}

class _ClosedBugsPageState extends State<ClosedBugsPage> {
  final dbBug = BugDao.instance;
  List<Map<String, dynamic>> bugListDone = [];

  @override
  void initState() {
    getAllBugsDone();
    super.initState();
  }

  Future<void> getAllBugsDone() async {
    var resp = await dbBug.getAllByState(1);
    setState(() {
      bugListDone = resp;
    });
  }

  void refreshDoneBugs(){getAllBugsDone();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Closed Bugs"),
          elevation: 0,
        ),
        body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              shrinkWrap: true,
              itemCount: bugListDone.length,
              itemBuilder: (context, index) {
                return ClosedBug(
                  key: UniqueKey(),
                  refreshHome: getAllBugsDone,
                  bug: Bug(
                    idBug: bugListDone[index]['idBug'],
                    description: bugListDone[index]['description'],
                    applicationName: bugListDone[index]['applicationName'],
                    state: bugListDone[index]['state'],
                    color: bugListDone[index]['color'],
                    correctOutcome: bugListDone[index]['correctOutcome'],
                    note: bugListDone[index]['note'],
                  ),
                  refreshDoneBugs: refreshDoneBugs,
                );
              }),
          const SizedBox(
            height: 20,
          )
        ]));
  }
}
