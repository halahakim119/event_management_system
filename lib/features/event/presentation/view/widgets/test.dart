import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = 'Response will be displayed here';

  void fetchData() async {
    final baseUrl = 'http://35.180.62.182';
    final endpoint = '/api/filter/host';
final requestData = {
  'province': 'AlAnbar',
  'minCapacity': '50',  // Convert to string
  'maxCapacity': '200', // Convert to string
  'services': ['Food', 'Entertainment'], // List of strings
  'category': 'Hotel',
};


    final Uri uri = Uri(
      scheme: 'http',
      host: '35.180.62.182',
      path: '/api/filter/host',
      queryParameters: requestData,
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          result = json.encode(data);
        });
      } else {
        setState(() {
          result = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Test App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  fetchData();
                },
                child: Text('Fetch Data'),
              ),
              SizedBox(height: 20),
              Text(
                'Response:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
