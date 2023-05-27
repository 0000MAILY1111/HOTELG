import 'package:flutter/material.dart';
import 'package:sw1_movil/screens/olvide_contrasena.dart';
import 'package:sw1_movil/screens/screens.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parte Movil SW1',
      initialRoute: 'login',
      routes: {
        'login': ( _ ) => LoginScreen(),
        'home' : ( _ ) => HomeScreen(),
        'register': (_) => RegisterScreen(),
        'olvide-contrasena': (_) => OlvideContrasenaScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}