import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String location;
  final String type;

  const DetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.location,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController reviewController = TextEditingController();
    double rating = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                image,
                errorBuilder: (context, error, stackTrace) => Image.asset('assets/default_image.png'),
              ),
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
                  onPressed: () => print("Button pressed"),
                  child: const Text('Show Menu'),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const Divider(), // Pembatas sebelum bagian "Write a Review"
            const SizedBox(height: 24.0),
            const Text('Write a Review', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 24.0),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30.0, // Ukuran sedang untuk bintang
              itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (newRating) => rating = newRating,
            ),
            const SizedBox(height: 24.0),
            const Text('Review', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),

            TextField(
              controller: reviewController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(), // Mengubah label menjadi kotak teks
                labelText: 'Type your review here',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                print('Review by ${nameController.text}: Rating: $rating, Comment: ${reviewController.text}');
              },
              child: const SizedBox( // Membungkus tombol ElevatedButton dengan SizedBox agar ukurannya lebih besar
                width: double.infinity, // Lebar tombol menjadi sepanjang layar
                child: Center( // Agar teks "Submit" berada di tengah tombol
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
