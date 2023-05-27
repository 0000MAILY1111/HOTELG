import 'package:flutter/material.dart';
import 'package:sw1_movil/providers/register_form_provider.dart';
import 'package:provider/provider.dart';

import 'package:sw1_movil/ui/input_decorations.dart';
import 'package:sw1_movil/widgets/widgets.dart';




class RegisterScreen extends StatelessWidget {

  const RegisterScreen({super.key});
 
  @override  
  Widget build(BuildContext context) {

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox( height: 200 ),

              CardContainer(
                child: Column(
                  children: [

                    SizedBox( height: 10 ),
                    Text('Register', style: Theme.of(context).textTheme.headline4 ),
                    SizedBox( height: 30 ),
                    
                    ChangeNotifierProvider(
                      create: ( _ ) => RegisterFormProvider(),
                      child: _RegisterForm()
                    )
                  ],
                )
              ),

              SizedBox( height: 20 ),

              GestureDetector(
                child: Text( '¿Olvidaste tu contraseña?',
                style: TextStyle( 
                        fontSize: 18,
                        fontWeight: FontWeight.bold 
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'olvide-contrasena');
                },
              ),

              SizedBox( height: 20 ),

              GestureDetector(
                child: Text('Iniciar Sesion',
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
            ],
          ),
        )
      )
   );
  }
}


class _RegisterForm extends StatelessWidget {
  
  const _RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {

    final RegisterForm = Provider.of<RegisterFormProvider>(context);
    

    return Container(
      child: Form(
        key: RegisterForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            
             TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'ejemplo123',
                labelText: 'Nombre de usuario',
                prefixIcon: Icons.perm_identity_rounded
              ),
              onChanged: ( value ) => RegisterForm.username = value,
              validator: ( value ) {
                  String pattern = r'^[a-zA-Z0-9]+$';
                  RegExp regExp  = new RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El nombre de usuario solo puede contener letras y números';
              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: ( value ) => RegisterForm.email = value,
              validator: ( value ) {
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),

            SizedBox( height: 30 ),

           TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => RegisterForm.password = value,
              validator: ( value ) {
                  return ((value != null && value.length >= 6) ?  null : 'La contraseña debe tener al menos 6 caracteres');
              },
            ),

            SizedBox( height: 30 ),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Confirmar contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: ( value ) => RegisterForm.confirmpassword = value,
              validator: ( value ) {
                  return ( (value==RegisterForm.password)
                    ? null
                    :'Las contraseñas no coinciden'
                  );
              },
            ),

            SizedBox( height: 30 ),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric( horizontal: 80, vertical: 15),
                child:Text(
                    RegisterForm.isLoading 
                      ? 'Espere'
                      : 'Registrar' 
                      ,
                  style: TextStyle( color: Colors.white ),
                )
              ),
              onPressed: RegisterForm.isLoading ? null : () async{
                
                FocusScope.of(context).unfocus();
                
                if( !RegisterForm.isValidForm() ) return;

                RegisterForm.isLoading = true;

                await Future.delayed(Duration(seconds: 2 ));

                // TODO: validar si el login es correcto
                RegisterForm.isLoading = false;

                Navigator.pushReplacementNamed(context, 'home');
              }
               
            )
          ],
        ),
      ),
    );
  }
}