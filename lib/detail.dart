// detail_page.dart
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String location;
  final String type;

  const DetailPage({
    Key? key,
    required this.title,
    required this.image,
    required this.location,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(image),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      type,
                      style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Button pressed");
                  },
                  child: const Text('Show Menu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
