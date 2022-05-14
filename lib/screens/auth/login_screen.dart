import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/configs.dart';
import 'package:senia_app/tools/tools.dart';
import 'package:senia_app/widgets/widgets.dart';
import 'package:senia_app/providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                _LoginForm(),
                SizedBox(height: 15),
                _LoginBtnRegister(),
                SizedBox(height: 15),
                _LoginSocialMedia(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormGeneralProvider>(context);
    return Form(
      key: formProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        child: Column(
          children: [
            Text(
              'Inicio de sesión',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            CustomTextFliedWidget(
              labelText: 'Correo electrónico',
              icon: Icons.email,
              onChanged: (value) => formProvider.email = value,
              enabled: !formProvider.isLoading,
              validator: ValidationsTools.emailValidation,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            CustomButtonWidget(
              text: !formProvider.isLoading ? 'Iniciar sesión' : 'Cancelar',
              onPressed: !formProvider.isLoading
                  ? () async {
                      FocusScope.of(context).unfocus();
                      if (!formProvider.isValidFrom()) return;
                      formProvider.isLoading = true;
                      await Future.delayed(Duration(seconds: 5));
                      formProvider.isLoading = false;
                    }
                  : () {
                      formProvider.isLoading = false;
                    },
              color: !formProvider.isLoading
                  ? AppTheme.accentColor
                  : AppTheme.dangerColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBtnRegister extends StatelessWidget {
  const _LoginBtnRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormGeneralProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    return CustomButtonWidget(
      text: !formProvider.isLoading ? 'Registrarse' : 'Cargando...',
      onPressed: !formProvider.isLoading
          ? () => uiProvider.authPage = StringScreens.SingUpScreen
          : null,
      color: AppTheme.secondaryColor,
    );
  }
}

class _LoginSocialMedia extends StatelessWidget {
  const _LoginSocialMedia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormGeneralProvider>(context);
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black,
          ),
          SizedBox(height: 15),
          Text(
            'Usa tus redes sociales',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          CustomButtonWidget(
            text: !formProvider.isLoading
                ? 'Iniciar sesión con google'
                : 'Cargando...',
            onPressed: !formProvider.isLoading ? () => print('google') : null,
            color: AppTheme.secondaryColor,
          ),
        ],
      ),
    );
  }
}
