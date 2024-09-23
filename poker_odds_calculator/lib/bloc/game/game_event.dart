abstract class GameEvent {}

class SelectTopMenuCardEvent extends GameEvent {
  final int index;
  final int p1score;
  final int p2score;

  SelectTopMenuCardEvent(this.index, this.p1score, this.p2score);
}

class SelectBottomMenuCardEvent extends GameEvent {
  final int index;
  final String cardName;
  final String cardType;
  final int p1score;
  final int p2score;

  SelectBottomMenuCardEvent(
      this.index, this.cardType, this.cardName, this.p1score, this.p2score);
}

class FinalGameEvent extends GameEvent {
  final int p1score;
  final int p2score;

  FinalGameEvent(this.p1score, this.p2score);
}

class RemoveLastRewindGame extends GameEvent {
  final int p1score;
  final int p2score;

  RemoveLastRewindGame(this.p1score, this.p2score);
}

class ClearSelectedCardsEvent extends GameEvent {}
