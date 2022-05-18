import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/configs.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/tools.dart';
import 'package:senia_app/widgets/widgets.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: AppTheme.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: ChangeNotifierProvider(
            create: (_) => FormGeneralProvider(),
            child: Column(
              children: [
                _SingUpForm(),
                SizedBox(height: 15),
                _SingUpBtnLogin(),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SingUpForm extends StatefulWidget {
  const _SingUpForm({
    Key? key,
  }) : super(key: key);

  @override
  __SingUpFormState createState() => __SingUpFormState();
}

class __SingUpFormState extends State<_SingUpForm> {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormGeneralProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Form(
      key: formProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        child: Column(
          children: [
            Text(
              'Registro',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            CustomTextFliedWidget(
              labelText: 'Nombre completo',
              icon: Icons.person,
              onChanged: (value) => formProvider.name = value,
              enabled: !formProvider.isLoading,
              validator: ValidationsTools.nameValidation,
              keyboardType: TextInputType.name,
            ),
            CustomTextFliedWidget(
              labelText: 'Correo electrónico',
              icon: Icons.email,
              onChanged: (value) => formProvider.email = value,
              enabled: !formProvider.isLoading,
              validator: ValidationsTools.emailValidation,
              keyboardType: TextInputType.emailAddress,
            ),
            CheckboxListTile(
              value: formProvider.isChecked,
              title: const Text('Aceptar términos y condiciones'),
              activeColor: AppTheme.accentColor,
              subtitle: Text(
                formProvider.isChecked
                    ? ''
                    : 'Acepta los términos y condiciones',
                style: TextStyle(color: AppTheme.dangerColor),
              ),
              onChanged: formProvider.isLoading
                  ? null
                  : (value) => setState(
                      () => formProvider.isChecked = !formProvider.isChecked),
            ),
            const Text(
              'Ver términos y condiciónes',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 15),
            CustomButtonWidget(
                text: !formProvider.isLoading ? 'Registrarse' : 'Cancelar',
                onPressed: !formProvider.isLoading
                    ? () async {
                        FocusScope.of(context).unfocus();
                        if (!formProvider.isValidFrom()) return;
                        if (!formProvider.isChecked) return;
                        formProvider.isLoading = true;

                        final resp = await userProvider.singup(
                            formProvider.name, formProvider.email);
                        if (resp.ok) {
                          CustomAlerts.showSimpleAlert(context, resp.message, 'Bienvenido ${resp.result.user!.nombre}. Inicia sesión para acceder a todas las funcionalidades');
                        } else {
                          CustomAlerts.showSimpleAlert(context, resp.message, resp.error);
                        }
                        formProvider.isLoading = false;
                      }
                    : () {
                        formProvider.isLoading = false;
                      },
                color: !formProvider.isLoading
                    ? AppTheme.accentColor
                    : AppTheme.dangerColor,
                icon: Icons.create),
          ],
        ),
      ),
    );
  }
}

class _SingUpBtnLogin extends StatelessWidget {
  const _SingUpBtnLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormGeneralProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    return CustomButtonWidget(
        text: !formProvider.isLoading ? 'Iniciar sesión' : 'Cargando...',
        onPressed: !formProvider.isLoading
            ? () => uiProvider.authPage = StringScreens.LoginScreen
            : null,
        color: AppTheme.secondaryColor,
        icon: Icons.login);
  }
}
