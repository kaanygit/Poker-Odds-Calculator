import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_bloc.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_event.dart';
import 'package:poker_odds_calculator/bloc/auth/auth_state.dart';
import 'package:poker_odds_calculator/utils/constants.dart';
import 'package:poker_odds_calculator/views/widgets/custom_circular_progress_indicator.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successful!')),
            );
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return CustomCircularProgressIndicator();
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              color: AppColors.darkGray,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Enter a beautiful world',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 40),
                        _buildTextField(usernameController, 'Username'),
                        SizedBox(height: 16),
                        _buildTextField(passwordController, 'Password',
                            obscureText: true),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (usernameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Username is required.')),
                              );
                            } else if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Password is required.')),
                              );
                            } else {
                              BlocProvider.of<AuthBloc>(context).add(
                                LoginEvent(
                                  usernameController.text,
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                          child: Text('Login',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
