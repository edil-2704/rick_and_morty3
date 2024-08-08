import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:rick_and_morty/features/auth/presentation/widgets/common_elevated_button.dart';
import 'package:rick_and_morty/internal/components/texr_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  final AuthBloc registrationBloc = AuthBloc();

  @override
  void initState() {
    registrationBloc.add(
      RegisterEvent(
        name: nameController.text,
        surname: secondNameController.text,
        patronym: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: registrationBloc,
        builder: (context, state) {
          log('state is ${state}');
          
          if (state is AuthErrorState) {
            return Center(
              child: Text('Error: ${state.error.message}'),
            );
          }

          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Создать аккаунт',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CommonTextWidget(tittle: 'Name'),
                    TextFieldWidget(
                      controller: nameController,
                      hintText: 'Name',
                    ),
                    CommonTextWidget(tittle: 'Surname'),
                    TextFieldWidget(
                      controller: nameController,
                      hintText: 'Surname',
                    ),
                    CommonTextWidget(tittle: 'Lastname'),
                    TextFieldWidget(
                      controller: nameController,
                      hintText: 'Lastname',
                    ),
                    SizedBox(height: 10),
                    Divider(height: 5),
                    SizedBox(height: 10),
                    CommonTextWidget(tittle: 'Login'),
                    TextFieldWidget(
                      controller: nameController,
                      hintText: 'Login',
                      prefixIcon: Icon(Icons.person),
                    ),
                    CommonTextWidget(tittle: 'Password'),
                    TextFieldWidget(
                      controller: nameController,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                    SizedBox(height: 10),
                    ElevatedButtonWidget(
                        onPressed: () {
                          registrationBloc.add(
                            RegisterEvent(
                              name: nameController.text,
                              surname: secondNameController.text,
                              patronym: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        title: 'Create'),
                  ],
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

class CommonTextWidget extends StatelessWidget {
  final String tittle;
  const CommonTextWidget({
    super.key,
    required this.tittle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      tittle,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
