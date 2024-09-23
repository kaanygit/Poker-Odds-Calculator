import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_event.dart';
import 'package:poker_odds_calculator/bloc/game/game_bloc.dart';
import 'package:poker_odds_calculator/bloc/game/game_state.dart';
import 'package:poker_odds_calculator/controllers/game_controller.dart';
import 'package:poker_odds_calculator/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> cardNameList = [
    "A",
    "K",
    "Q",
    "J",
    "10",
    "9",
    "8",
    "7",
    "6",
    "5",
    "4",
    "3",
    "2"
  ];
  final List<String> cardTypeNameList = ["maca", "karo", "sinek", "kupa"];

  @override
  Widget build(BuildContext context) {
    final GameController _gameController = GameController(context);
    return Scaffold(
      backgroundColor: AppColors.darkGray,
      appBar: appBar(),
      body: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
        if (state.selectedCards.length == 9) {
          _gameController.finalScoreGame();
        }
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(3, (index) {
                            return GestureDetector(
                              onTap: () {
                                int sendIndex = index;
                                _gameController.topMenuCardSelected(sendIndex);
                              },
                              child: Builder(
                                builder: (context) {
                                  var selectedCard;

                                  for (var card in state.selectedCards) {
                                    if (card.selectedCardIndex == index) {
                                      selectedCard = card;
                                      break;
                                    }
                                  }

                                  if (selectedCard != null) {
                                    return Container(
                                      width: 50,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              selectedCard.cardName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Image.asset(
                                              'assets/icons/${selectedCard.cardType}.png',
                                              height: 30,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              state.selectedCardIndex == index
                                                  ? Colors.pink.shade100
                                                  : Colors.transparent,
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/icons/closed_card.png',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 50,
                                          height: 100,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        Row(
                          children: List.generate(2, (index) {
                            return GestureDetector(
                              onTap: () {
                                int sendIndex = index + 3;
                                _gameController.topMenuCardSelected(sendIndex);
                              },
                              child: Builder(
                                builder: (context) {
                                  var selectedCard;

                                  for (var card in state.selectedCards) {
                                    if (card.selectedCardIndex == index + 3) {
                                      selectedCard = card;
                                      break;
                                    }
                                  }

                                  if (selectedCard != null) {
                                    return Container(
                                      width: 50,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              selectedCard.cardName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Image.asset(
                                              'assets/icons/${selectedCard.cardType}.png',
                                              height: 30,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: state.selectedCardIndex ==
                                                  index + 7
                                              ? Colors.pink.shade100
                                              : Colors.transparent,
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/icons/closed_card.png',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 50,
                                          height: 100,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.white),
                        top: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              children: List.generate(2, (index) {
                            return GestureDetector(
                              onTap: () {
                                int sendIndex = index + 5;
                                _gameController.topMenuCardSelected(sendIndex);
                              },
                              child: Builder(
                                builder: (context) {
                                  var selectedCard;

                                  for (var card in state.selectedCards) {
                                    if (card.selectedCardIndex == index + 5) {
                                      selectedCard = card;
                                      break;
                                    }
                                  }

                                  if (selectedCard != null) {
                                    return Container(
                                      width: 50,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              selectedCard.cardName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Image.asset(
                                              'assets/icons/${selectedCard.cardType}.png',
                                              height: 30,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: state.selectedCardIndex ==
                                                  index + 5
                                              ? Colors.pink.shade100
                                              : Colors.transparent,
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/icons/closed_card.png',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 50,
                                          height: 100,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          })),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "P1",
                                  style: AppColors.customTextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Set Cards",
                                  style: AppColors.customTextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "%${state.p1}",
                                  style: AppColors.customTextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Win Rate",
                                  style: AppColors.customTextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.white),
                        top: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              children: List.generate(2, (index) {
                            return GestureDetector(
                              onTap: () {
                                int sendIndex = index + 7;
                                _gameController.topMenuCardSelected(sendIndex);
                              },
                              child: Builder(
                                builder: (context) {
                                  var selectedCard;

                                  for (var card in state.selectedCards) {
                                    if (card.selectedCardIndex == index + 7) {
                                      selectedCard = card;
                                      break;
                                    }
                                  }

                                  if (selectedCard != null) {
                                    return Container(
                                      width: 50,
                                      margin: EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              selectedCard.cardName,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Image.asset(
                                              'assets/icons/${selectedCard.cardType}.png',
                                              height: 30,
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: state.selectedCardIndex ==
                                                  index + 7
                                              ? Colors.pink.shade100
                                              : Colors.transparent,
                                          width: 5,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/icons/closed_card.png',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: 50,
                                          height: 100,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          })),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "P2",
                                  style: AppColors.customTextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Set Cards",
                                  style: AppColors.customTextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "%${state.p2}",
                                  style: AppColors.customTextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Win Rate",
                                  style: AppColors.customTextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Add",
                                      style: AppColors.customTextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      "Player",
                                      style: AppColors.customTextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                  ),
                                  child: Text(
                                    "+",
                                    style: AppColors.customTextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Dead",
                                      style: AppColors.customTextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    Text(
                                      "Cards",
                                      style: AppColors.customTextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                  ),
                                  child: Text(
                                    "+",
                                    style: AppColors.customTextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      (state.selectedCards.length == 9)
                          ? IconButton(
                              onPressed: () {
                                _gameController.clearGame();
                              },
                              icon: Icon(
                                Icons.refresh,
                                size: 50,
                                color: Colors.white,
                              ),
                            )
                          : Container()
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: state.isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child:
                    state.isVisible ? openingSelectingCardMenu() : Container(),
              ),
            ),
          ],
        );
      }),
      drawer: drawerMenu(),
    );
  }

  Widget openingSelectingCardMenu() {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 13,
              childAspectRatio: 0.6,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: cardNameList.length * cardTypeNameList.length,
            itemBuilder: (context, index) {
              String cardName = cardNameList[index % cardNameList.length];
              String cardType = cardTypeNameList[index ~/ cardNameList.length];

              bool isSelected = state.selectedCards.any((card) =>
                  card.index == index &&
                  card.cardType == cardType &&
                  card.cardName == cardName);

              Color textColor = (cardType == "maca" || cardType == "sinek")
                  ? Colors.black
                  : Colors.red;

              return GestureDetector(
                onTap: isSelected
                    ? null
                    : () {
                        print(index);
                        final GameController _gameController =
                            GameController(context);
                        _gameController.bottomMenuCardSelected(
                            index, cardType, cardName);
                        print(cardType);
                        print(cardName);
                      },
                child: Card(
                  elevation: 4,
                  color: isSelected ? Colors.grey : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                      color: isSelected ? Colors.orange.shade700 : Colors.grey,
                      width: 2.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cardName,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Image.asset(
                        'assets/icons/$cardType.png',
                        height: 16,
                        width: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  AppBar appBar() {
    final GameController _gameController = GameController(context);

    return AppBar(
      backgroundColor: AppColors.darkGray,
      iconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Center(
        child: Text(
          'Set Players Cards',
          style: TextStyle(color: Colors.white),
        ),
      ),
      actions: [
        BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            return state.selectedCards.length != 9
                ? IconButton(
                    onPressed: () {
                      _gameController.lastRewindGame();
                    },
                    icon: Icon(
                      Icons.fast_rewind,
                    ),
                  )
                : SizedBox.shrink();
          },
        ),
        IconButton(
          onPressed: () {
            _gameController.clearGame();
          },
          icon: Icon(
            Icons.refresh,
          ),
        ),
      ],
    );
  }

  Drawer drawerMenu() {
    return Drawer(
      backgroundColor: AppColors.darkGray,
      child: ListView(
        padding: EdgeInsets.all(25),
        children: [
          DrawerHeader(
              child: Text(
            "Menu",
            style: AppColors.customTextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          )),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              "Sign Out",
              style: AppColors.customTextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent(context));
            },
          )
        ],
      ),
    );
  }
}
