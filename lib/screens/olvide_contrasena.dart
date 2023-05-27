import 'package:flutter/material.dart';
import 'package:sw1_movil/providers/login_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:sw1_movil/ui/input_decorations.dart';
import 'package:sw1_movil/widgets/widgets.dart';


class OlvideContrasenaScreen extends StatelessWidget {

  const OlvideContrasenaScreen({Key? key});
 
  @override  
  Widget build(BuildContext context) {
    
    return Scaffold(

      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox( height: 250 ),

              CardContainer(
                child: Column(
                  children: [

                    SizedBox( height: 10 ),
                    Text('Recuperar contraseña', style: Theme.of(context).textTheme.headline4 ),
                    SizedBox( height: 30 ),
                    
                    _OlvideContrasenaForm(),

                  ],
                )
              ),

              SizedBox( height: 20 ),
              

              GestureDetector(
                child: Text( '¿Ya tienes una cuenta? Inicia Sesión',
                style: TextStyle( 
                        fontSize: 18,
                        fontWeight: FontWeight.bold 
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
              ),

              SizedBox( height: 20 ),

              GestureDetector(
                child: Text('¿Quieres registrarte? dale click',
                style: TextStyle( 
                        fontSize: 18,
                        fontWeight: FontWeight.bold 
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'register');
                },
              ),

              SizedBox( height: 20 ),

            ],
          ),
        )
      )
   );
  }
}

class _OlvideContrasenaForm extends StatefulWidget {
  const _OlvideContrasenaForm({Key? key}) : super(key: key);

  @override
  __OlvideContrasenaFormState createState() => __OlvideContrasenaFormState();
}

class __OlvideContrasenaFormState extends State<_OlvideContrasenaForm> {
  final _formKey = GlobalKey<FormState>();

  String? _email;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => _email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    'Enviar',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_formKey.currentState!.validate()) {
                  // TODO: enviar correo electrónico para recuperar contraseña
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}