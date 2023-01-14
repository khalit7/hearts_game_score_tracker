import 'package:flutter/material.dart';
import 'package:hearts_game/ui/pages/score_page.dart';

import 'package:hearts_game/utils/shared_variables.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _playerNames = List.filled(4,"NULL");
  bool _disable_button = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Players Names'),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Player ${index + 1}'),
              onChanged: (String value) {
                setState(() {
                  _playerNames[index] = value;
                  _playerNames.contains("NULL")? _disable_button=true : _disable_button = false;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _disable_button? null : () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Player Names: $_playerNames'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Start Game'),
                    onPressed: () {
                      players_list = _playerNames;
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ScorePage()),
                              );

                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}