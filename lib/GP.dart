import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderPredictionPage extends StatefulWidget {
  @override
  _GenderPredictionPageState createState() => _GenderPredictionPageState();
}

class _GenderPredictionPageState extends State<GenderPredictionPage> {

  TextEditingController _nameController = TextEditingController();
  String _genderPrediction = '';
  bool _isLoading = false;

  Future<void> fetchGenderPrediction(String name) async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl = 'https://api.genderize.io?name=$name';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _genderPrediction = '${data['name']} is probably ${data['gender']}';
        });
      } else {
        setState(() {
          _genderPrediction = 'Failed to predict gender.';
        });
      }
    } catch (error) {
      setState(() {
        _genderPrediction = 'Error: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gender Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchGenderPrediction(_nameController.text.trim());
              },
              child: Text(
                'Check',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              height: 20,
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Text(
              _genderPrediction,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}