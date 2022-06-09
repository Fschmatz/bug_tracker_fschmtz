import 'dart:async';
import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/pages/newBug.dart';
import 'package:bug_tracker_fschmtz/widgets/openBug.dart';
import 'package:flutter/material.dart';

class BugList extends StatefulWidget {
  const BugList({Key? key}) : super(key: key);

  @override
  _BugListState createState() => _BugListState();
}

class _BugListState extends State<BugList> {
  bool loading = true;
  final dbBug = BugDao.instance;
  List<Map<String, dynamic>> bugList = [];

  @override
  void initState() {
    getAllBugsNotDone();
    super.initState();
  }

  Future<void> getAllBugsNotDone() async {
    var resp = await dbBug.getAllByState(0);
    setState(() {
      bugList = resp;
    });
  }

  void refreshHome() {
    getAllBugsNotDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              shrinkWrap: true,
              itemCount: bugList.length,
              itemBuilder: (context, index) {
                return OpenBug(
                  refreshDoneBugs: refreshHome,
                  key: UniqueKey(),
                  bug: Bug(
                    idBug: bugList[index]['idBug'],
                    description: bugList[index]['description'],
                    applicationName: bugList[index]['applicationName'],
                    state: bugList[index]['state'],
                    color: bugList[index]['color'],
                    correctOutcome: bugList[index]['correctOutcome'],
                    note: bugList[index]['note'],
                  ),
                  refreshHome: refreshHome,
                );
              }),
          const SizedBox(
            height: 50,
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NewBug(),
                )).then((value) => getAllBugsNotDone());
          },
          child: const Icon(
            Icons.add_outlined,
          ),
        )


    );
  }}
