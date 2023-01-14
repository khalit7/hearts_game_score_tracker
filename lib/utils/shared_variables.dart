
var players_list = List.filled(4,"NULL");


var all_rounds_scores = List.generate(1, (i) => List.filled(4,0), growable: true);
var total_scores = List.filled(4,0);
int currentRound = 0;