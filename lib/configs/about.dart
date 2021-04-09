import 'package:flutter/material.dart';
import '../util/nameChangelog.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(6,0,6,5),
          child: ListView(
              children: <Widget>[
                const SizedBox(height: 20),
                Text(NameChangelog.appName+" " + NameChangelog.appVersion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 25),

                CircleAvatar(
                  radius: 55,
                  backgroundColor: Theme.of(context).accentColor,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                ),

                Text( '''                     
                
HAMMERED AND REDONE:
0 Times !!!
( This is The Way! )  
     
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),


                Text( '''                     
                                
Application created using
Flutter and the Dart language,
used for testing and learning.
            
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    //fontWeight: FontWeight.bold
                  ),
                ),

                Text( ''' 
                    
" Any fool can know.
The point is to understand. "
- Albert Einstein             
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ]),
        )
    );

  }
}

