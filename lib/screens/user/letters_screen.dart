import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_routes.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/tools.dart';

class LetterScreen extends StatelessWidget {
  const LetterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letterProvider = Provider.of<LetterProvider>(context);
    final letters = letterProvider.letters;

    return RefreshIndicator(
      onRefresh: () {
        final respFuture = letterProvider.getLetters();
        respFuture.then((resp) {
          if (!resp.ok) {
            CustomAlerts.showSimpleAlert(context, resp.message, resp.error);
          } 
        });
        return respFuture;
      },
      child: ListView.builder(
        itemCount: letters.length,
        itemBuilder: (_, index) => _ItemListLetter(letter: letters[index]),
      ),
    );
  }
}
// _ItemListLetter(image: 'assets/logo.png', letter: 'N', percentaje: 10)

class _ItemListLetter extends StatelessWidget {
  final LetterModel letter;

  const _ItemListLetter({
    Key? key,
    required this.letter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: ListTile(
          tileColor: AppTheme.primaryColor,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          minVerticalPadding: 10,
          leading: Image(
            image: AssetImage('assets/logo.png'),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(
              'Letra ${letter.name} - ${CalcsTools.getPromedioPorcentageLetter(letter)}% registrado'),
          onTap: () => Navigator.pushNamed(
              context, AppRoutes.routesApp['letterDescription']!.route,
              arguments: letter),
        ),
      ),
    );
  }
}
