import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_event.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_state.dart';
import 'package:poker_odds_calculator/bloc/game/game_bloc.dart';
import 'package:poker_odds_calculator/controllers/auth_controller.dart';
import 'package:poker_odds_calculator/views/home_screen.dart';
import 'package:poker_odds_calculator/views/login_screen.dart';
import 'package:poker_odds_calculator/views/signup_screen.dart';
import 'package:poker_odds_calculator/views/widgets/custom_circular_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthController authController = AuthController();
  runApp(MyApp(authController: authController));
}

class MyApp extends StatelessWidget {
  final AuthController authController;

  MyApp({required this.authController});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authController)..add(CheckLoginStatusEvent()),
        ),
        BlocProvider<GameBloc>(create: (context) => GameBloc()),
      ],
      child: MaterialApp(
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Scaffold(
                body: CustomCircularProgressIndicator(),
              );
            } else if (state is AuthSuccess &&
                state.message == 'Already logged in.') {
              return HomeScreen();
            }
            return LoginScreen();
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
