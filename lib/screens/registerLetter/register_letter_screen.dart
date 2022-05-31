import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_routes.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/models/letter_model.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/alerts_tools.dart';
import 'package:senia_app/tools/calcs_tools.dart';
import 'package:senia_app/widgets/custom_button_widget.dart';

class RegisterLetterScreen extends StatelessWidget {
  const RegisterLetterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letterProvider = Provider.of<LetterProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final letters = CalcsTools.getLetterForRegister(letterProvider.letters);

    return Scaffold(
        appBar: AppBar(title: const Text('Registrar letras')),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _RegisterLetterSelectionLetter(letters: letters),
                SizedBox(height: 15),
                uiProvider.letterSelected.name != ''
                    ? _RegisterLetterSelectionHand()
                    : SizedBox(),
                SizedBox(height: 15),
                uiProvider.letterSelected.name != '' &&
                        uiProvider.handSelected != ''
                    ? _RegisterLetterConfirmation()
                    : SizedBox()
              ],
            ),
          ),
        ));
  }
}

class _RegisterLetterConfirmation extends StatelessWidget {
  const _RegisterLetterConfirmation({
    Key? key,
  }) : super(key: key);

  bool isValid(UiProvider uiProvider) {
    return uiProvider.letterSelected.name != '' &&
        uiProvider.handSelected != '';
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final letterProvider = Provider.of<LetterProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirmación',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Letra seleccionada: ${uiProvider.letterSelected.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Mano seleccionada: ${uiProvider.handSelected}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 20),
                CustomButtonWidget(
                  text: 'Iniciar registro',
                  onPressed: isValid(uiProvider)
                      ? () {
                          letterProvider
                              .createLetter(uiProvider.letterSelected,
                                  uiProvider.handSelected)
                              .then((resp) {
                            if (resp.ok) {
                              uiProvider.letterRegister = resp.result.letter!;
                              Navigator.pushNamed(context,
                                  AppRoutes.routesApp['captureLetter']!.route);

                              uiProvider.letterSelected = LetterModel.empty();
                              uiProvider.handSelected = "";
                            } else {
                              CustomAlerts.showSimpleAlert(
                                  context, resp.message, resp.error);
                            }
                          });
                        }
                      : null,
                  color: AppTheme.secondaryColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _RegisterLetterSelectionHand extends StatelessWidget {
  const _RegisterLetterSelectionHand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final hands = uiProvider.letterSelected.hands;
    return _RegisterLetterContent(
      title: '¿Con qué mano harás el registro?',
      height: 250,
      itemCount: hands.length,
      itemBuilder: (_, index) => _RegisterLetterCard(
        title: hands[index].hand,
        letter: hands[index].hand,
        image: 'assets/logo.png',
        onPressed: () {
          uiProvider.handSelected = hands[index].hand;
        },
      ),
    );
  }
}

class _RegisterLetterSelectionLetter extends StatelessWidget {
  const _RegisterLetterSelectionLetter({
    Key? key,
    required this.letters,
  }) : super(key: key);

  final List<LetterModel> letters;

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return _RegisterLetterContent(
      title: 'Escoger letra',
      height: 250,
      itemCount: letters.length,
      itemBuilder: (_, index) => _RegisterLetterCard(
          title: 'letra',
          letter: letters[index].name,
          image: letters[index].image,
          onPressed: () {
            uiProvider.letterSelected = letters[index];
          }),
    );
  }
}

class _RegisterLetterContent extends StatelessWidget {
  final String title;
  final double height;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const _RegisterLetterContent({
    Key? key,
    required this.title,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
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
              height: height,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: itemBuilder,
                itemCount: itemCount,
              )),
        )
      ],
    );
  }
}

class _RegisterLetterCard extends StatelessWidget {
  final String title;
  final String letter;
  final String image;
  final void Function()? onPressed;

  const _RegisterLetterCard({
    Key? key,
    required this.title,
    required this.letter,
    required this.onPressed,
    this.image = 'assets/logo.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Card(
      color: uiProvider.letterSelected.name == letter ||
              uiProvider.handSelected == letter
          ? AppTheme.selectedColor
          : AppTheme.primaryColor,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage(image),
              width: 100,
            ),
            SizedBox(height: 10),
            CustomButtonWidget(
                text: 'Seleccionar',
                onPressed: onPressed,
                color: AppTheme.secondaryColor)
          ],
        ),
      ),
    );
  }
}
