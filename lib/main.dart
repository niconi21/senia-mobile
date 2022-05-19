import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:senia_app/configs/app_theme.dart';
import 'package:senia_app/providers/providers.dart';

import 'configs/app_routes.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LetterProvider(context: context)),
        ChangeNotifierProvider(create: (context) => ImagenProvider(context: context)),
        
      ],
      child: MaterialApp(
        title: 'Señia',
        routes: AppRoutes.getRoutesApp(),
        initialRoute: AppRoutes.initialRoute,
        theme: AppTheme.theme,
        
      ),
    );
  }
}



