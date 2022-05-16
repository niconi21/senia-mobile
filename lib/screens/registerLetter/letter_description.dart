import 'package:flutter/material.dart';
import 'package:senia_app/configs/app_theme.dart';

class LetterDescriptionScreen extends StatelessWidget {
  const LetterDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descripción de la letra'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _LetterDescriptionResumenCardLetter(
              image: 'assets/logo.png',
              type: 'Entrenamiento',
              percentaje: 100,
              date: '15 de mayo del 2022',
              time: '13:15:55',
            ),
            _LetterDescriptionResumenCardLetter(
              image: 'assets/logo.png',
              type: 'Validación',
              percentaje: 100,
              date: '15 de mayo del 2022',
              time: '13:15:55',
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterDescriptionResumenCardLetter extends StatelessWidget {
  final String image;
  final String type;
  final double percentaje;
  final String date;
  final String time;

  const _LetterDescriptionResumenCardLetter({
    Key? key,
    required this.image,
    required this.type,
    required this.percentaje,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Image(image: AssetImage(image), width: 100),
            SizedBox(height: 10),
            Text(
              type,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$percentaje% terminado'),
                Text('Fecha: $date'),
                Text('Hora: $time'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _LetterDescriptionContent extends StatelessWidget {
  final Widget child;
  const _LetterDescriptionContent({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: child),
      ),
    );
  }
}
