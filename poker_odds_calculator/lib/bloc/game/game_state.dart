import 'package:poker_odds_calculator/models/card_model.dart';

class GameState {
  final List<SelectedCard> selectedCards;
  final int selectedCardIndex;
  final int tappedTwiceIndex;
  final bool isVisible;
  final bool selectCardTopMenu;
  final int p1;
  final int p2;

  GameState(
      {this.selectedCards = const [],
      this.selectedCardIndex = -1,
      this.tappedTwiceIndex = -1,
      this.isVisible = false,
      this.selectCardTopMenu = false,
      this.p1 = 0,
      this.p2 = 0});

  GameState copyWith(
      {List<SelectedCard>? selectedCards,
      int? selectedCardIndex,
      int? tappedTwiceIndex,
      bool? isVisible,
      bool? selectCardTopMenu,
      int? p1,
      int? p2}) {
    return GameState(
        selectedCards: selectedCards ?? this.selectedCards,
        selectedCardIndex: selectedCardIndex ?? this.selectedCardIndex,
        tappedTwiceIndex: tappedTwiceIndex ?? this.tappedTwiceIndex,
        isVisible: isVisible ?? this.isVisible,
        selectCardTopMenu: selectCardTopMenu ?? this.selectCardTopMenu,
        p1: p1 ?? this.p1,
        p2: p2 ?? this.p2);
  }
}
