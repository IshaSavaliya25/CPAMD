import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/screens/services/locle_service.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var localservice = Provider.of<LocaleService>(context);
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: Text("English")),
        ElevatedButton(onPressed: () {}, child: Text("Arabic")),
      ],
    );
  }
}
