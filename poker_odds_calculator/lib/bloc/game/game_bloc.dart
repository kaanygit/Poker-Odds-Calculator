import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poker_odds_calculator/bloc/game/game_event.dart';
import 'package:poker_odds_calculator/bloc/game/game_state.dart';
import 'package:poker_odds_calculator/models/card_model.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState()) {
    on<SelectTopMenuCardEvent>(_onSelectTopMenuCard);
    on<SelectBottomMenuCardEvent>(_onBottomSelectIndexOnAddCard);
    on<FinalGameEvent>(_onFinalScoreGame);
    on<RemoveLastRewindGame>(_onRewindLastGame);
    on<ClearSelectedCardsEvent>(_onClearSelectedCards);
  }

  void _onSelectTopMenuCard(
      SelectTopMenuCardEvent event, Emitter<GameState> emit) {
    print('Event index: ${event.index}');

    int newSelectedCardIndex;
    int newTappedTwiceIndex;
    bool newIsVisible = state.isVisible;
    bool newSelectCardTopMenu = state.selectCardTopMenu;

    if (state.tappedTwiceIndex == event.index) {
      newSelectedCardIndex = -1;
      newTappedTwiceIndex = -10;
    } else {
      newSelectedCardIndex = event.index;
      newTappedTwiceIndex = event.index;
      newIsVisible = true;
      newSelectCardTopMenu = true;
    }

    final newState = state.copyWith(
      selectedCardIndex: newSelectedCardIndex,
      tappedTwiceIndex: newTappedTwiceIndex,
      isVisible: newIsVisible,
      selectCardTopMenu: newSelectCardTopMenu,
    );

    emit(newState);
  }

  void _onBottomSelectIndexOnAddCard(
      SelectBottomMenuCardEvent event, Emitter<GameState> emit) {
    if (state.selectCardTopMenu) {
      SelectedCard _selectedCard = SelectedCard(
        selectedCardIndex: state.selectedCardIndex,
        cardType: event.cardType,
        cardName: event.cardName,
        index: event.index,
      );

      List<SelectedCard> updatedSelectedCards = List.from(state.selectedCards)
        ..add(_selectedCard);
      emit(state.copyWith(
          selectedCards: updatedSelectedCards,
          p1: event.p1score,
          p2: event.p2score));
    }
  }

  void _onFinalScoreGame(FinalGameEvent event, Emitter<GameState> emit) {
    emit(state.copyWith(
      selectedCardIndex: -1,
      tappedTwiceIndex: -1,
      isVisible: false,
      selectCardTopMenu: false,
    ));
  }

  void _onRewindLastGame(RemoveLastRewindGame event, Emitter<GameState> emit) {
    if (state.selectedCards.isNotEmpty) {
      emit(state.copyWith(
          selectedCards: List.from(state.selectedCards)..removeLast(),
          selectedCardIndex: -10,
          p1: event.p1score,
          p2: event.p2score));
    }
  }

  void _onClearSelectedCards(
      ClearSelectedCardsEvent event, Emitter<GameState> emit) {
    if (state.selectedCards.isNotEmpty) {
      emit(state.copyWith(
          selectedCards: [],
          selectedCardIndex: -1,
          tappedTwiceIndex: -1,
          isVisible: false,
          selectCardTopMenu: false,
          p1: 0,
          p2: 0));
    }
  }
}
