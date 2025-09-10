import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/controllers/quote_controller.dart';

class QuoteScreen extends StatelessWidget {
  QuoteScreen({super.key});

  QuoteController controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Quotes App'),
        actions: [
          IconButton(
            onPressed: () {
              controller.fetchData();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.quote.value.q}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${controller.quote.value.a}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
