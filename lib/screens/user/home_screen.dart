import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_routes.dart';
import 'package:senia_app/configs/app_theme.dart';
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
        title: Text(uiProvider.homePageName),
      ),
      body: _HomeScreenBody(),
      floatingActionButton: _HomeFloatingActionsButtons(),
      bottomNavigationBar: _HomeBottomNavigationBar(),
    );
  }
}

class _HomeFloatingActionsButtons extends StatelessWidget {
  const _HomeFloatingActionsButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'RegisterLetter',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.routesApp['registerLetter']!.route),
          child: Icon(Icons.add_a_photo),
          tooltip: "Agregar datos",
          backgroundColor: AppTheme.unselectedColor,
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          heroTag: 'ReadLsm',
          onPressed: () => Navigator.pushNamed(context, AppRoutes.routesApp['lsm']!.route),
          child: Icon(Icons.camera),
          tooltip: "Leer Lenguaje de Señas",
          backgroundColor: AppTheme.secondaryColor,
        ),
      ],
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

class _HomeBottomNavigationBar extends StatelessWidget {
  const _HomeBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return BottomNavigationBar(
      currentIndex: uiProvider.homePage,
      onTap: (index) {
        uiProvider.homePage = index;
        switch (index) {
          case 0:
            uiProvider.homePageName = StringScreens.homeScreenName;
            break;
          case 1:
            uiProvider.homePageName = StringScreens.lettersScreenName;
            break;
          case 2:
            uiProvider.homePageName = StringScreens.profileScreenName;
            break;
          default:
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled), label: 'Notas'),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file), label: 'Letras'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfíl'),
      ],
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 50),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Text(
                    'Reprehenderit magna eiusmod eu officia pariatur sunt occaecat eiusmod cupidatat deserunt occaecat in veniam incididunt. Veniam reprehenderit qui adipisicing dolore minim qui commodo excepteur incididunt magna amet aliqua. Quis id laboris duis aliquip anim incididunt labore enim dolore non qui eiusmod veniam cillum. Laboris pariatur proident incididunt excepteur eu mollit veniam excepteur enim laborum labore culpa nisi.'),
                SizedBox(height: 10),
                Text(
                    'Reprehenderit magna eiusmod eu officia pariatur sunt occaecat eiusmod cupidatat deserunt occaecat in veniam incididunt. Veniam reprehenderit qui adipisicing dolore minim qui commodo excepteur incididunt magna amet aliqua. Quis id laboris duis aliquip anim incididunt labore enim dolore non qui eiusmod veniam cillum. Laboris pariatur proident incididunt excepteur eu mollit veniam excepteur enim laborum labore culpa nisi.'),
                SizedBox(height: 10),
                Text(
                    'Reprehenderit magna eiusmod eu officia pariatur sunt occaecat eiusmod cupidatat deserunt occaecat in veniam incididunt. Veniam reprehenderit qui adipisicing dolore minim qui commodo excepteur incididunt magna amet aliqua. Quis id laboris duis aliquip anim incididunt labore enim dolore non qui eiusmod veniam cillum. Laboris pariatur proident incididunt excepteur eu mollit veniam excepteur enim laborum labore culpa nisi.'),
                SizedBox(height: 10),
                Text(
                    'Reprehenderit magna eiusmod eu officia pariatur sunt occaecat eiusmod cupidatat deserunt occaecat in veniam incididunt. Veniam reprehenderit qui adipisicing dolore minim qui commodo excepteur incididunt magna amet aliqua. Quis id laboris duis aliquip anim incididunt labore enim dolore non qui eiusmod veniam cillum. Laboris pariatur proident incididunt excepteur eu mollit veniam excepteur enim laborum labore culpa nisi.'),
                SizedBox(height: 10),
                Text(
                    'Reprehenderit magna eiusmod eu officia pariatur sunt occaecat eiusmod cupidatat deserunt occaecat in veniam incididunt. Veniam reprehenderit qui adipisicing dolore minim qui commodo excepteur incididunt magna amet aliqua. Quis id laboris duis aliquip anim incididunt labore enim dolore non qui eiusmod veniam cillum. Laboris pariatur proident incididunt excepteur eu mollit veniam excepteur enim laborum labore culpa nisi.'),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
