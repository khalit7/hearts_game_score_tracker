import 'package:flutter/material.dart';

import 'package:hearts_game/constants.dart';


calculate_round_score (round_eat_array){
    var round_score  = List.filled(4,0);
    var num_of_gallon = 0;
    for (var i = 0; i < round_eat_array.length; i++) {
                if (round_eat_array[i] == 0)
                num_of_gallon= num_of_gallon + 1;
            }

    if  (num_of_gallon == 0) {

        for (var i = 0; i < round_eat_array.length; i++) {
            round_score[i] = round_eat_array[i] - 5;
            }

    }

        if  (num_of_gallon == 1) {

        for (var i = 0; i < round_eat_array.length; i++) {
            if (round_eat_array[i] == 0) round_score[i] = -20;
            else round_score[i] = round_eat_array[i];
            }

    }

            
        if  (num_of_gallon == 2) {

        for (var i = 0; i < round_eat_array.length; i++) {
            if (round_eat_array[i] == 0) round_score[i] = -10;
            else round_score[i] = round_eat_array[i];
            }

    }

        if  (num_of_gallon == 3) {

        for (var i = 0; i < round_eat_array.length; i++) {
            if (round_eat_array[i] == 0) round_score[i] = -6;
            else round_score[i] = 18;
            }

    }

    return round_score;
}


class ScorePage extends StatefulWidget {
  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
    List<String> _playerNames = players_list;
  bool disable_next_round = true;
  int _currentRound = 0;

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
            child: Text("Round $_currentRound"),
          ),
          DataTable(
            columns: <DataColumn>[
              DataColumn(label: Text("Player")),
              DataColumn(label: Text("round 0")),
              ...List.generate(_currentRound, (_) => DataColumn(label: Text("Round ${_ + 1}"))),
              DataColumn(label: Text("Total")),
            ],
            rows: List.generate(
              4,
              (index) => DataRow(
                cells: [
                  DataCell(Text(_playerNames[index])),
                  DataCell(Text(all_rounds_scores[0][index].toString())),
                  ...List.generate(
                    _currentRound,
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
          ),
          Text("Enter how many points did each player eat at round ${_currentRound+1}", textAlign: TextAlign.center,),
          DataTable(
            columns:<DataColumn> [
                DataColumn(label: Text("Player")),
                DataColumn(label: Text("round ${_currentRound+1}")),
            ],
            rows: List.generate(
              4,
              (index) => DataRow(
                cells: [
                  DataCell(Text(_playerNames[index])),
                  DataCell(
                TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController()..text = '${curr_player_eat[index]}',
                        onChanged: (value) {
                          setState(() {
                            curr_player_eat[index] = int.parse(value);
                            var sum = 0;
                            for (var i = 0; i < curr_player_eat.length; i++) {
                                            sum += curr_player_eat[i];
                                        }
                            sum != 20?disable_next_round=true:disable_next_round=false;
                            
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
      floatingActionButton: disable_next_round?Text("FIX IT"):FloatingActionButton(
        onPressed: () {
              setState(() {
                var arr_to_add = calculate_round_score(curr_player_eat);
                all_rounds_scores.add(arr_to_add);
                _currentRound++;
                disable_next_round= true;
                for (var i = 0; i < curr_player_eat.length; i++) {
                curr_player_eat[i] = 0 ;
                total_scores[i] = total_scores[i] + arr_to_add[i] as int;
            }
            print(total_scores);
              });
            },
             child: Icon(Icons.check),
      )
    );
  }
}