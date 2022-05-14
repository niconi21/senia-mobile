import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/tools.dart';

import '../screens.dart';

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Column(
              children: [
                _AuthHomeHeader(),
                SizedBox(height: 40),
                _AuthHomeBody()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthHomeBody extends StatelessWidget {
  const _AuthHomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    switch(uiProvider.authPage){
      case StringScreens.LoginScreen:
        return LoginScreen();
      case StringScreens.SingUpScreen:
        return SingUpScreen();
      default:
        return LoginScreen();
    }
  }
}


class _AuthHomeHeader extends StatelessWidget {
  const _AuthHomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SEÑIA',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Identificación del Lenguaje de señas Mexicano',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25,
        ),
        Image(
          image: AssetImage('assets/logo.png'),
          width: 150,
        )
      ],
    );
  }
}
