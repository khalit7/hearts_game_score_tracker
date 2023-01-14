import 'package:flutter/material.dart';

import 'package:hearts_game/utils/shared_variables.dart';
import 'package:hearts_game/utils/game_logic.dart';




class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
    List<String> _playerNames = players_list;
    bool _disable_next_round = true;

List<TextEditingController> _player_eat_controller = List.generate(4, (i) => TextEditingController());

initState(){
super.initState();

for (var i = 0; i < _player_eat_controller.length; i++) _player_eat_controller[i].text = "0";

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hearts Game"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Round $currentRound"),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text("Player")),
              DataColumn(label: Text("round 0")),
              ...List.generate(currentRound, (_) => DataColumn(label: Text("Round ${_ + 1}"))),
              DataColumn(label: Text("Total")),
            ],
            rows: List.generate(
              4,
              (index) => DataRow(
                cells: [
                  DataCell(Text(_playerNames[index])),
                  DataCell(Text(all_rounds_scores[0][index].toString())),
                  ...List.generate(
                    currentRound,
                    (round) => DataCell(
                        Text("${all_rounds_scores[round+1][index]}")
                    ),
                  ),
                  DataCell(Text(
                      "${total_scores[index]}"
                  )),
                ],
              ),
            ),
          )
      ),
          Text("Enter how many points did each player eat at round ${currentRound+1}", textAlign: TextAlign.center,),
          DataTable(
            columns:<DataColumn> [
                DataColumn(label: Text("Player")),
                DataColumn(label: Text("round ${currentRound+1}")),
            ],
            rows: List.generate(
              4,
              (index) => DataRow(
                cells: [
                  DataCell(Text(_playerNames[index])),
                  DataCell(
                TextField(
                    keyboardType: TextInputType.number,
                    controller: _player_eat_controller[index],
                        onChanged: (value) {
                            for (var i=0;i<_player_eat_controller.length;i++){
                                if (_player_eat_controller[i].text == "") {
                                    _disable_next_round=true;
                                    return;
                                }
                            }

                            var sum = 0;
                            for (var i = 0; i < _player_eat_controller.length; i++) {
                                String current_player_eat = _player_eat_controller[i].text;
                                sum += int.parse(_player_eat_controller[i].text);
                                        }
                          setState(() {
                            sum != 20?_disable_next_round=true:_disable_next_round=false;
                            
                          });
                        }
                )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: _disable_next_round?Text("NOT BALANCED"):FloatingActionButton(
        onPressed: () {
              setState(() {
                var arr_to_add = GameLogic.calculate_round_score(_player_eat_controller);
                all_rounds_scores.add(arr_to_add);
                currentRound++;
                _disable_next_round= true;
                for (var i = 0; i < _player_eat_controller.length; i++) {
                _player_eat_controller[i].text = "0" ;
                total_scores[i] = total_scores[i] + arr_to_add[i] as int;
            }
              });
            },
             child: Icon(Icons.check),
      )
    );
  }
}