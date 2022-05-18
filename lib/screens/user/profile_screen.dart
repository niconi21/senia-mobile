import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_routes.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/providers/providers.dart';
import 'package:senia_app/tools/tools.dart';
import 'package:senia_app/tools/valitations_tools.dart';
import 'package:senia_app/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 50, top: 10),
        child: ChangeNotifierProvider(
          create: (_) => FormGeneralProvider(),
          child: Column(
            children: [
              _ProfileLogOut(),
              _ProfileForm(),
              _ProfileDeleteAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileLogOut extends StatelessWidget {
  const _ProfileLogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final formProvider = Provider.of<FormGeneralProvider>(context);
    return _ProfileContent(children: [
      Text('¿Deseas cerrar tu sesión?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
      SizedBox(height: 10),
      CustomButtonWidget(
        text: 'Cerrar sesión',
        onPressed: !formProvider.isLoading
            ? () {
                userProvider.logout();
                Navigator.popAndPushNamed(
                    context, AppRoutes.routesApp['auth']!.route);
              }
            : null,
        color: !formProvider.isLoading
            ? AppTheme.dangerColor
            : AppTheme.unselectedColor,
        icon: Icons.logout,
      )
    ]);
  }
}

class _ProfileForm extends StatelessWidget {
  const _ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final formProvider = Provider.of<FormGeneralProvider>(context);
    formProvider.name = userProvider.user.nombre;
    formProvider.email = userProvider.user.correo;

    return Form(
      key: formProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: _ProfileContent(children: [
        Text('Información del usuario',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        SizedBox(height: 15),
        Text('ID de usuario: ${userProvider.user.id}'),
        SizedBox(height: 10),
        CustomTextFliedWidget(
            labelText: 'Nombre completo',
            intialValue: userProvider.user.nombre,
            icon: Icons.person,
            onChanged: (value) => formProvider.name = value,
            enabled: true,
            validator: ValidationsTools.nameValidation,
            keyboardType: TextInputType.name),
        SizedBox(height: 10),
        CustomTextFliedWidget(
            labelText: 'Correo electrónico',
            icon: Icons.email,
            intialValue: userProvider.user.correo,
            onChanged: (value) => formProvider.email = value,
            enabled: true,
            validator: ValidationsTools.emailValidation,
            keyboardType: TextInputType.emailAddress),
        SizedBox(height: 15),
        Text('Medio de autenticación: Correo Electrónico'),
        SizedBox(height: 10),
        Text(
            'Dado de alta el: ${DateTools.getDate(userProvider.user.createdAt)}'),
        SizedBox(height: 10),
        Text(
            'Última actualización el: ${DateTools.getDate(userProvider.user.updatedAt)}'),
        SizedBox(height: 15),
        CustomButtonWidget(
            text:
                !formProvider.isLoading ? 'Actualizar información' : 'Cargando...',
            onPressed: !formProvider.isLoading
                ? () {
                    FocusScope.of(context).unfocus();
                    if (!formProvider.isValidFrom()) return;
                    formProvider.isLoading = true;
                    userProvider
                        .updateUser(formProvider.name, formProvider.email)
                        .then((resp) {
                      if (resp.ok)
                        CustomAlerts.showSimpleAlert(
                            context, resp.message, 'Información actualizada');
                      else
                        CustomAlerts.showSimpleAlert(
                            context, resp.message, resp.error);
                    }).whenComplete(() => formProvider.isLoading = false);
                  }
                : null,
            color: !formProvider.isLoading
                ? AppTheme.secondaryColor
                : AppTheme.dangerColor,
            icon: Icons.upload)
      ]),
    );
  }
}

class _ProfileDeleteAccount extends StatelessWidget {
  const _ProfileDeleteAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final formProvider = Provider.of<FormGeneralProvider>(context);
    return _ProfileContent(children: [
      Text('¿Deseas eliminar tu cuenta?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
      SizedBox(height: 10),
      Text(
          'Tempor labore ipsum incididunt fugiat ut occaecat ut magna amet eiusmod enim. Nostrud anim reprehenderit nostrud quis esse ut. Velit ex aute ut ea id nulla est nulla do ex cupidatat ipsum qui. Nulla dolor amet ex fugiat veniam mollit consectetur cillum ad amet pariatur non officia.'),
      SizedBox(height: 5),
      Text('- Elit aute aute enim exercitation.'),
      Text('- Elit aute aute enim exercitation.'),
      Text('- Elit aute aute enim exercitation.'),
      Text('- Elit aute aute enim exercitation.'),
      Text('- Elit aute aute enim exercitation.'),
      SizedBox(height: 15),
      CustomButtonWidget(
          text: 'Eliminar Cuenta',
          onPressed: !formProvider.isLoading
              ? () {
                  userProvider.deleteAccount().then((resp) {
                    Navigator.popAndPushNamed(
                        context, AppRoutes.routesApp['auth']!.route);
                  }).whenComplete(() {});
                }
              : null,
          color: !formProvider.isLoading
              ? AppTheme.dangerColor
              : AppTheme.unselectedColor,
          icon: Icons.delete_forever)
    ]);
  }
}

class _ProfileContent extends StatelessWidget {
  final List<Widget> children;

  const _ProfileContent({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
