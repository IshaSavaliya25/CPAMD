import 'package:flutter/material.dart';
import "package:sensors_plus/sensors_plus.dart";
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor Data Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SensorPage(),
    );
  }
}

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  // Accelerometer sensor values
  double _accelerometerX = 0.0;
  double _accelerometerY = 0.0;
  double _accelerometerZ = 0.0;

  // Gyroscope sensor values
  double _gyroscopeX = 0.0;
  double _gyroscopeY = 0.0;
  double _gyroscopeZ = 0.0;

  // Magnetometer sensor values
  double _magnetometerX = 0.0;
  double _magnetometerY = 0.0;
  double _magnetometerZ = 0.0;

  // Stream subscriptions
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;
  StreamSubscription<MagnetometerEvent>? _magnetometerSubscription;

  @override
  void initState() {
    super.initState();

    // Initialize Accelerometer listener
    _accelerometerSubscription =
        // ignore: deprecated_member_use
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerX = event.x;
        _accelerometerY = event.y;
        _accelerometerZ = event.z;
      });
    });

    // Initialize Gyroscope listener
    // ignore: deprecated_member_use
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeX = event.x;
        _gyroscopeY = event.y;
        _gyroscopeZ = event.z;
      });
    });

    // Initialize Magnetometer listener
    _magnetometerSubscription =
        // ignore: deprecated_member_use
        magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerX = event.x;
        _magnetometerY = event.y;
        _magnetometerZ = event.z;
      });
    });
  }

  @override
  void dispose() {
    // Cancel subscriptions to avoid memory leaks
    _accelerometerSubscription?.cancel();
    _gyroscopeSubscription?.cancel();
    _magnetometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Data Analyzer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Accelerometer:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('X: ${_accelerometerX.toStringAsFixed(2)}'),
            Text('Y: ${_accelerometerY.toStringAsFixed(2)}'),
            Text('Z: ${_accelerometerZ.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            const Text(
              'Gyroscope:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('X: ${_gyroscopeX.toStringAsFixed(2)}'),
            Text('Y: ${_gyroscopeY.toStringAsFixed(2)}'),
            Text('Z: ${_gyroscopeZ.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            const Text(
              'Magnetometer:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('X: ${_magnetometerX.toStringAsFixed(2)}'),
            Text('Y: ${_magnetometerY.toStringAsFixed(2)}'),
            Text('Z: ${_magnetometerZ.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
