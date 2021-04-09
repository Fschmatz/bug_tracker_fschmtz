import 'dart:async';
import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:bug_tracker_fschmtz/configs/configs.dart';
import 'package:bug_tracker_fschmtz/db/bugDao.dart';
import 'package:bug_tracker_fschmtz/pages/newBug.dart';
import 'package:bug_tracker_fschmtz/widgets/cardItem.dart';
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
    getAllBugs();
    super.initState();
  }

  Future<void> getAllBugs() async {
    var resp = await dbBug.queryAllRows();
    setState(() {
      bugList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('BugTracker',
            style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: 18)),
      ),
      body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
            shrinkWrap: true,
            itemCount: bugList.length,
            itemBuilder: (context, index) {
              return CardItem(
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
              );
            }),
        const SizedBox(
          height: 20,
        )
      ]),
      floatingActionButton: Container(
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color(0xFF404144),
            elevation: 0.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NewBug(),
                    fullscreenDialog: true,
                  )).then((value) => getAllBugs());
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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.done_outline,
                  size: 24,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () {

                }),
            IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 24,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => Configs(),
                        fullscreenDialog: true,
                      ));
                }),
          ],
        ),
      )),
    );
  }
}
