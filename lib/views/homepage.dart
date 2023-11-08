import 'package:flutter/material.dart';
import 'package:flutter_template/views/model_page.dart';
import 'package:flutter_template/views/reentreno.dart';
import 'package:flutter_template/views/register_page.dart';
import 'package:flutter_template/widgets/fields/textfield.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../widgets/alerts/alerta_generica.dart';
import '../widgets/buttons/button_login.dart';
import '../widgets/fields/input_decorations.dart';
import 'home_page.dart';

// ignore: camel_case_types
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<StatefulWidget> createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReentrenoPage()),
                  );
                }, child: const Text('Reentreno'),

              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ModelPage()),
                  );
                }, child: const Text('Modelo'),

              ),


            ],
          ),
        ),
      ),
    );
  }
}