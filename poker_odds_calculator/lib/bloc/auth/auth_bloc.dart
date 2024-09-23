import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_event.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_state.dart';
import 'package:poker_odds_calculator/controllers/auth_controller.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthController authController;

  AuthBloc(this.authController) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final message = await authController.login(event.username, event.password);
    print('mesaj geldi $message');
    if (message != null) {
      emit(AuthSuccess(message));
    } else {
      emit(AuthFailure('Login failed.'));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final message = await authController.signUp(
        event.username, event.password, event.email);
    if (message != null) {
      emit(AuthSuccess(message));
    } else {
      emit(AuthFailure('Sign up failed.'));
    }
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatusEvent event, Emitter<AuthState> emit) async {
    final isLoggedIn = await authController.checkLoginStatus();
    if (isLoggedIn) {
      emit(AuthSuccess('Already logged in.'));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await authController.logout(event.context);
    emit(AuthInitial());
  }
}
