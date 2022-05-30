import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_routes.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/models/models.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/date_tools.dart';
import 'package:senia_app/tools/tools.dart';
import 'package:senia_app/widgets/custom_button_widget.dart';

class LetterDescriptionScreen extends StatelessWidget {
  const LetterDescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letterPrvider = Provider.of<LetterProvider>(context);
    final LetterModel letterData =
        ModalRoute.of(context)?.settings.arguments as LetterModel;
    final lettersComplete = CalcsTools.getTotalHandsInLetters(letterData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Descripción de la letra ${letterData.name}'),
        actions: [
          IconButton(
            onPressed: () {
              CustomAlerts.showOptoinAlert(
                  context,
                  '¿Seguro que desea eliminar este registro?',
                  "Se eliminará por completo el registro de sus fotografías",
                  'Eliminar registro', () {
                lettersComplete.forEach((letter) {
                  letterPrvider.deleteLetter(letter.id);
                });
                Navigator.pop(context);
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.delete_forever, color: AppTheme.dangerColor),
            tooltip: 'Eliminar registro por completo',
          )
        ],
      ),
      body: ListView.builder(
        itemCount: lettersComplete.length,
        itemBuilder: (context, index) => _LetterDescriptionCard(
          letter: lettersComplete[index],
        ),
      ),
    );
  }
}

class _LetterDescriptionCard extends StatelessWidget {
  LetterModel letter;
  _LetterDescriptionCard({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Mano ${letter.hand}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Text('Letra ${letter.name}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Image(
                image: AssetImage('assets/logo.png'),
                width: 100,
              ),
              SizedBox(height: 10),
              Text('Tipo: ${letter.type}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              SizedBox(height: 10),
              Text('Porcentaje: ${letter.percentage}%',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              SizedBox(height: 10),
              Text('Fecha: ' + DateTools.getDate(letter.createdAt),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              SizedBox(height: 10),
              letter.percentage < 100
                  ? CustomButtonWidget(
                      text: 'Finalizar registro',
                      onPressed: () {
                        uiProvider.letterRegister = letter;
                        Navigator.pushNamed(context,
                            AppRoutes.routesApp['captureLetter']!.route);
                      },
                      color: AppTheme.secondaryColor)
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
