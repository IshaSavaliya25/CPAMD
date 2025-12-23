import 'package:flutter/material.dart';
import 'package:user_app/controller/app_controller.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({Key? key}) : super(key: key);

  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  int r = 127;
  int g = 255;
  int b = 255;
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AppController>(context);
    return Container(
      color: Color.fromRGBO(r, g, b, opacity),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: (r / 255).toDouble(),
              onChanged: (val) {
                setState(() {
                  r = (val * 255).toInt();
                });
                debugPrint('r: $r');
              },
            ),
            Slider(
              value: (g / 255).toDouble(),
              onChanged: (val) {
                setState(() {
                  g = (val * 255).toInt();
                });
                debugPrint('g: $g');
              },
            ),
            Slider(
              value: (b / 255).toDouble(),
              onChanged: (val) {
                setState(() {
                  b = (val * 255).toInt();
                });
                debugPrint('b: $b');
              },
            ),
            Text('Color Screen', style: TextStyle(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}
