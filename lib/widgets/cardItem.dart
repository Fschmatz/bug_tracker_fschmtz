import 'package:bug_tracker_fschmtz/classes/bug.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  @override
  _CardItemState createState() => _CardItemState();

  int index;
  Bug bug;

  CardItem({Key key,this.index,this.bug}) : super(key: key);
}

class _CardItemState extends State<CardItem> {


void bottomMenuShowItem() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)),
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
                            leading: CircleAvatar(backgroundColor: Color(int.parse(widget.bug.color.substring(6, 16))),radius: 15,),
                            title: Text(
                              widget.bug.description,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.edit_outlined, size: 22),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Icon(Icons.notes_rounded, size: 22),
                            title: Text(
                              widget.bug.correctOutcome,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.notes_rounded, size: 22),
                            title: Text(
                              widget.bug.errorDescription,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: ListTile(
                              leading: Icon(Icons.notes_rounded, size: 22),
                              title: Text(
                                widget.bug.note,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Card(
                              margin: const EdgeInsets.fromLTRB(130, 0, 130, 0),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                //leading: Icon(Icons.done_outline, size: 22),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.done_outline, size: 20),
                                    SizedBox(width: 25,),
                                    Text(
                                      "Done",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                onTap: (){

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: Text(widget.bug.description,style: TextStyle(fontSize: 16),),
          subtitle: Text(widget.bug.errorDescription,style: TextStyle(fontSize: 14.5),),
          leading: CircleAvatar(backgroundColor: Color(int.parse(widget.bug.color.substring(6, 16)))),
          onTap: (){
            bottomMenuShowItem();
            print('Bomba !');
          },
        ),
      ),
    );
  }
}
