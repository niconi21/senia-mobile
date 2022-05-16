import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/providers/providers.dart';

import 'configs/app_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UiProvider())],
      child: MaterialApp(
        title: 'Material App',
        routes: AppRoutes.getRoutesApp(),
        initialRoute: AppRoutes.initialRoute,
        theme: AppTheme.theme,
      ),
    );
  }
}
