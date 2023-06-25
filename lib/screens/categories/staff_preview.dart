import 'package:flutter/material.dart';
import 'package:sliate/color.dart';

class StaffPreview extends StatelessWidget {
  final String staffName;
  final String position;
  final String imageUrl;
  final String field;
  final String staffId;

  const StaffPreview({
    super.key,
    required this.staffName,
    required this.position,
    required this.imageUrl,
    required this.field,
    required this.staffId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg_clr,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    staffName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: text_clr,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    position,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Field:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: text_clr,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              field,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Staff ID:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: text_clr,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              staffId,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Contact Details:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: text_clr,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Email: example@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Phone: 123-456-7890',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
