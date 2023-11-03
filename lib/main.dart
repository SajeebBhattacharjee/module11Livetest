import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class WeatherInfo {
  final String city;
  final int temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  WeatherInfo({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      city: json['city'],
      temperature: json['temperature'],
      condition: json['condition'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String jsonString = '''
  [
    {
      "city": "New York",
      "temperature": 20,
      "condition": "Clear",
      "humidity": 60,
      "windSpeed": 5.5
    },
    {
      "city": "Los Angeles",
      "temperature": 25,
      "condition": "Sunny",
      "humidity": 50,
      "windSpeed": 6.8
    },
    {
      "city": "London",
      "temperature": 15,
      "condition": "Partly Cloudy",
      "humidity": 70,
      "windSpeed": 4.2
    },
    {
      "city": "Tokyo",
      "temperature": 28,
      "condition": "Rainy",
      "humidity": 75,
      "windSpeed": 8.0
    },
    {
      "city": "Sydney",
      "temperature": 22,
      "condition": "Cloudy",
      "humidity": 55,
      "windSpeed": 7.3
    }
  ]
  ''';

  List<WeatherInfo> cities = [];

  @override
  void initState() {
    super.initState();
    final List<dynamic> jsonList = json.decode(jsonString);
    cities = jsonList.map((json) => WeatherInfo.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Info App'),
        ),
        body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            var city = cities[index];
            return Card(
              child: ListTile(
                title: Text(city.city),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Temperature: ${city.temperature}°C'),
                    Text('Condition: ${city.condition}'),
                    Text('Humidity: ${city.humidity}%'),
                    Text('Wind Speed: ${city.windSpeed} km/h'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
