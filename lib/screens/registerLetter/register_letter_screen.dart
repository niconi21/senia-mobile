import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/calcs_tools.dart';
import 'package:senia_app/widgets/custom_button_widget.dart';

class RegisterLetterScreen extends StatelessWidget {
  const RegisterLetterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letterProvider = Provider.of<LetterProvider>(context);
    final letters = CalcsTools.getLetters(letterProvider.letters);
    return Scaffold(
        appBar: AppBar(title: const Text('Registrar letras')),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              _RegisterLetterContent(
                title: 'Escoger letra',
                children: [
                  _RegisterLetterCard(
                    title: 'letra',
                    letter: 'A',
                  ),
                  _RegisterLetterCard(
                    title: 'letra',
                    letter: 'A',
                  ),
                  _RegisterLetterCard(
                    title: 'letra',
                    letter: 'A',
                  ),
                  _RegisterLetterCard(
                    title: 'letra',
                    letter: 'A',
                  ),
                ],
              ),
              SizedBox(height: 15),
              _RegisterLetterContent(
                title: '¿Con qué mano harás el registro?',
                children: [
                  _RegisterLetterCard(
                      title: 'Derecha', image: 'assets/logo.png'),
                  _RegisterLetterCard(
                      title: 'Izquierda', image: 'assets/logo.png'),
                ],
              ),
              SizedBox(height: 15),
              CustomButtonWidget(
                text: 'Iniciar registro',
                onPressed: () {},
                color: AppTheme.secondaryColor,
              )
            ],
          ),
        ));
  }
}

class _RegisterLetterContent extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _RegisterLetterContent({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _RegisterLetterCard extends StatelessWidget {
  final String title;
  final String letter;
  final String image;

  const _RegisterLetterCard({
    Key? key,
    required this.title,
    this.letter = '',
    this.image = 'assets/logo.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            letter != ''
                ? Text(
                    letter,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  )
                : Image(
                    image: AssetImage(image),
                    width: 100,
                  ),
            SizedBox(height: 10),
            CustomButtonWidget(
                text: 'Seleccionar',
                onPressed: () {},
                color: AppTheme.secondaryColor)
          ],
        ),
      ),
    );
  }
}
