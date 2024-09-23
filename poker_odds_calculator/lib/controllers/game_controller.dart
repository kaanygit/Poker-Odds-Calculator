import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poker_odds_calculator/bloc/game/game_bloc.dart';
import 'package:poker_odds_calculator/bloc/game/game_event.dart';

class GameController {
  final BuildContext context;

  GameController(this.context);

  Map<String, int> generateValues() {
    int value1 = Random().nextInt(101);
    int value2 = 100 - value1;

    return {
      'value1': value1,
      'value2': value2,
    };
  }

  void topMenuCardSelected(int index) {
    Map<String, int> values = generateValues();

    BlocProvider.of<GameBloc>(context).add(
        SelectTopMenuCardEvent(index, values['value1']!, values['value2']!));
  }

  void bottomMenuCardSelected(int index, String cardType, String cardName) {
    Map<String, int> values = generateValues();
    BlocProvider.of<GameBloc>(context).add(
      SelectBottomMenuCardEvent(
          index, cardType, cardName, values['value1']!, values['value2']!),
    );
  }

  void finalScoreGame() {
    Map<String, int> values = generateValues();
    BlocProvider.of<GameBloc>(context).add(
      FinalGameEvent(values['value1']!, values['value2']!),
    );
  }

  void lastRewindGame() {
    Map<String, int> values = generateValues();
    BlocProvider.of<GameBloc>(context).add(
      RemoveLastRewindGame(values['value1']!, values['value2']!),
    );
  }

  void clearGame() {
    BlocProvider.of<GameBloc>(context).add(ClearSelectedCardsEvent());
  }
}
