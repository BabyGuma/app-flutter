import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/sidebar.dart';

class ReentrenoPage extends StatefulWidget {
  const ReentrenoPage({Key? key}) : super(key: key);

  @override
  State<ReentrenoPage> createState() => _ReentrenoPageState();
}

class _ReentrenoPageState extends State<ReentrenoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController urlController = TextEditingController();

  String generateSHA() {
    final now = DateTime.now().toString();
    final bytes = utf8.encode(now);
    final sha = sha1.convert(bytes);
    return sha.toString();
  }

  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  String? scoreText;

  Future<void> reTrainModel(String urlUser) async {
    try {
      final String url = 'https://api.github.com/repos/BabyGuma/Prediccion/dispatches';
      
      final shaGenerate = generateSHA();

      final Map<String, dynamic> requestBody = {
        "event_type": "ml_ci_cd",
        "client_payload": {
          "dataseturl": urlUser,
          "sha": shaGenerate,
        }
      };

      final String basicAuth = 'Bearer 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';

      final dio = Dio();

      dio.options.headers['Accept'] = 'application/vnd.github.v3+json';
      dio.options.headers['Authorization'] = basicAuth;

      final response = await dio.post(
        url,
        data: jsonEncode(requestBody),
      );

      if (response.statusCode == 204) {
        print('Solicitud enviada con éxito');
      } else {
        print('Error al enviar la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  void dispose() {
    urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () => _openDrawer(context),
        ),
      ),
      drawer: const SideBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: urlController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Url',border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  reTrainModel(urlController.text);
                },
                child: Text('Reentrenar modelo'),
              ),
              SizedBox(height: 20),
              if (scoreText != null)
                Text(
                  'Modelo reentrenado',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }

}