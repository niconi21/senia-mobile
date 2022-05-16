import 'package:flutter/material.dart';
import 'package:senia_app/configs/app_theme.dart';

class LetterScreen extends StatelessWidget {
  const LetterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: [
        _ItemListLetter(image: 'assets/logo.png', letter: 'A', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'B', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'C', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'D', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'E', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'F', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'G', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'H', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'I', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'J', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'K', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'L', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'M', percentaje: 10),
        _ItemListLetter(image: 'assets/logo.png', letter: 'N', percentaje: 10),
        
      ],
    );
  }
}

class _ItemListLetter extends StatelessWidget {
  final String letter;
  final double percentaje;
  final String image;

  const _ItemListLetter({
    Key? key,
    required this.letter,
    required this.percentaje,
    required this.image,
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
            image: AssetImage(image),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text('Letra $letter - $percentaje% registrado'),
          onTap: () {},
        ),
      ),
    );
  }
}
