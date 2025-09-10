import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // make options full width
          children: [
            // Question text
            Text(
              'Long Long Question Available Long Long Question Available Long Long Question Available Long Long Question Available Long Long Question Available Long Long Question Available Long Long Question Available',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Options
            for (int i = 1; i < 5; i++)
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Option $i',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('Previous')),
                  ElevatedButton(onPressed: () {}, child: Text('Next')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
