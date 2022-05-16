import 'package:flutter/material.dart';
import 'package:senia_app/configs/app_routes.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 50, top: 10),
        child: Column(
          children: [
            _ProfileLogOut(),
            _ProfileForm(),
            _ProfileDeleteAccount(),
          ],
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
    return _ProfileContent(children: [
      Text('¿Deseas cerrar tu sesión?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
      SizedBox(height: 10),
      CustomButtonWidget(
        text: 'Cerrar sesión',
        onPressed: () => Navigator.popAndPushNamed(
            context, AppRoutes.routesApp['auth']!.route),
        color: AppTheme.dangerColor,
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
    return _ProfileContent(children: [
      Text('Información del usuario',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
      SizedBox(height: 15),
      Text('ID de usuario: 12345678901234567890'),
      SizedBox(height: 10),
      CustomTextFliedWidget(
          labelText: 'Nombre completo',
          icon: Icons.person,
          onChanged: (value) {},
          enabled: true,
          validator: (value) => null,
          keyboardType: TextInputType.name),
      SizedBox(height: 10),
      CustomTextFliedWidget(
          labelText: 'Correo electrónico',
          icon: Icons.email,
          onChanged: (value) {},
          enabled: true,
          validator: (value) => null,
          keyboardType: TextInputType.emailAddress),
      SizedBox(height: 15),
      Text('Medio de autenticación: Correo Electrónico'),
      SizedBox(height: 10),
      Text('Dado de alta el: 12 de abril del 2020 a las 12:43:23'),
      SizedBox(height: 10),
      Text('Última actualización el: 12 de abril del 2020 a las 12:43:23'),
      SizedBox(height: 15),
      CustomButtonWidget(
          text: 'Actualizar información',
          onPressed: () {},
          color: AppTheme.secondaryColor,
          icon: Icons.upload)
    ]);
  }
}

class _ProfileDeleteAccount extends StatelessWidget {
  const _ProfileDeleteAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          color: AppTheme.dangerColor,
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
