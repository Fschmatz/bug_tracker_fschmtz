import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../db/bugDao.dart';

class PrintBugsList extends StatefulWidget {
  PrintBugsList({Key? key}) : super(key: key);

  @override
  _PrintBugsListState createState() => _PrintBugsListState();
}

class _PrintBugsListState extends State<PrintBugsList> {
  List<Map<String, dynamic>> playlists = [];
  final db = BugDao.instance;
  bool loading = true;
  String formattedList = '';

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  void getNotes() async {
    List<Map<String, dynamic>> _list = await db.queryAllRows();

    for (int i = 0; i < _list.length; i++) {
      formattedList += _list[i]['applicationName'] + "\n";
      formattedList += _list[i]['description']+ "\n";
      formattedList += _list[i]['correctOutcome'] + "\n";
      if(_list[i]['howWasSolved'].toString().isNotEmpty){
        formattedList += _list[i]['howWasSolved']+ "\n";
      }
      if(_list[i]['note'].toString().isNotEmpty){
        formattedList += _list[i]['note'] + "\n";
      }
      formattedList += "\n*******************\n\n";
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print'),
        actions: [
          TextButton(
            child: const Text(
              "Copy",
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: formattedList));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        children: [
          loading
              ? const SizedBox.shrink()
              : SelectableText(
            formattedList,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

