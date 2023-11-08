import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/sidebar.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({Key? key}) : super(key: key);

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController hourController = TextEditingController();



  void _openDrawer(BuildContext context) {
    _scaffoldKey.currentState!.openDrawer();
  }

  String? scoreText;

  Future<void> getScore() async {
    try {
      String endpoint = 'https://predictionspo-service-babyguma.cloud.okteto.net/spotify';
      final response = await Dio().post(endpoint, data: {
        "country": countryController.text ?? "",
        "year": int.tryParse(yearController.text) ?? 0,
        "month": int.tryParse(monthController.text) ?? 0,
        "day": int.tryParse(dayController.text) ?? 0,
        "hour": int.tryParse(hourController.text) ?? 0,

      });

      setState(() {
        scoreText = response.data.toString();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    countryController.dispose();
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    hourController.dispose();

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
              extField(
                 controller: countryController,
                 keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Country',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'year',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20),
              TextField(
                controller: monthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'month',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20),
              TextField(
                controller: dayController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'day',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20),
              TextField(
                controller: hourController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'hour',border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  getScore();
                },
                child: Text('Obtener Cantante'),
              ),
              SizedBox(height: 20),
              if (scoreText != null)
                Text(
                  'Resultado: $scoreText',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }

}