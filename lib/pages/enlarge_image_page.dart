import 'package:flutter/material.dart';

class EnlargeImagePage extends StatelessWidget {
  final String imagePath;
  final String title;

  // The constructor requires both image path and dynamic title
  const EnlargeImagePage({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Dynamic title reflects the classroom name
        title: Text('${title} Image'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        // Allows zoom and pan functionality
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Text(
                'Image not found!',
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
