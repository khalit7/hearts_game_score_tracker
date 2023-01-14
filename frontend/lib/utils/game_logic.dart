
class GameLogic {

static calculate_round_score (all_player_eat_text_controller){

    var round_eat_array = List.filled(4,0);

    for (var i=0; i<all_player_eat_text_controller.length;i++) {
        round_eat_array[i] = int.parse( all_player_eat_text_controller[i].text );
    }

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

}