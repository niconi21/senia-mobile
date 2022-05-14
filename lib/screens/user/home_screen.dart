import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/screens/user/user_screen.dart';
import 'package:senia_app/tools/tools.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Señia  '),
      ),
      body: _HomeScreenBody(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => print('capure pics'),
            child: Icon(Icons.add_a_photo),
            tooltip: "Agregar datos",
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () => print('read lsm'),
            child: Icon(Icons.camera),
            tooltip: "Leer Lenguaje de Señas",
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: uiProvider.homePage,
        onTap: (index) {
          uiProvider.homePage = index;
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file), label: 'Letras'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfíl'),
        ],
      ),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    switch (uiProvider.homePage) {
      case StringScreens.homeScreen:
        return _HomeScreen();
      case StringScreens.lettersScreen:
        return LetterScreen();
      case StringScreens.profileScreen:
        return ProfileScreen();
      default:
        return _HomeScreen();
    }
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}
