import 'package:flutter/material.dart';
import 'package:poker_odds_calculator/models/user_model.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent(this.username, this.password);
}

class SignUpEvent extends AuthEvent {
  // final User user;
  final String username;
  final String password;
  final String email;
  SignUpEvent(this.username, this.password,this.email);
}

class CheckLoginStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {
  final BuildContext context;

  LogoutEvent(this.context);
}
