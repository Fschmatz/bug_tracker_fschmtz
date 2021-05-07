import 'dart:async';
import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/configs/settings.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/pages/doneBugs.dart';
import 'package:bug_tracker_fschmtz/pages/newBug.dart';
import 'package:bug_tracker_fschmtz/widgets/bugHome.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  void refreshHome(){getAllBugsNotDone();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('BugTracker',
            ),
      ),
      body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            shrinkWrap: true,
            itemCount: bugList.length,
            itemBuilder: (context, index) {
              return BugHome(
                key: UniqueKey(),
                bug: Bug(
                  idBug: bugList[index]['idBug'],
                  description:bugList[index]['description'],
                  state: bugList[index]['state'],
                  color: bugList[index]['color'],
                  correctOutcome: bugList[index]['correctOutcome'],
                  errorDescription:bugList[index]['errorDescription'],
                  note: bugList[index]['note'],
              ),
                refreshHome: refreshHome,
              );
            }),
        const SizedBox(
          height: 20,
        )
      ]),
      floatingActionButton: Container(
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color(0xFF424242),
            elevation: 0.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NewBug(),
                    fullscreenDialog: true,
                  )).then((value) => getAllBugsNotDone());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.done_outline,
                  color: Theme.of(context)
                      .textTheme
                      .headline6
                      .color
                      .withOpacity(0.7),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => DoneBugs(),
                        fullscreenDialog: true,
                      )).then((value) => getAllBugsNotDone());
                }),
            IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Theme.of(context)
                      .textTheme
                      .headline6
                      .color
                      .withOpacity(0.7),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Settings(),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
      )),
    );
  }
}
