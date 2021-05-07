import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/widgets/bugDone.dart';
import 'package:flutter/material.dart';

class DoneBugs extends StatefulWidget {
  @override
  _DoneBugsState createState() => _DoneBugsState();
}

class _DoneBugsState extends State<DoneBugs> {
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
          title: Text("Done Bugs"),
          elevation: 0,
        ),
        body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              shrinkWrap: true,
              itemCount: bugListDone.length,
              itemBuilder: (context, index) {
                return BugDone(
                  key: UniqueKey(),
                  bug: Bug(
                    idBug: bugListDone[index]['idBug'],
                    description: bugListDone[index]['description'],
                    state: bugListDone[index]['state'],
                    color: bugListDone[index]['color'],
                    correctOutcome: bugListDone[index]['correctOutcome'],
                    errorDescription: bugListDone[index]['errorDescription'],
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
