import 'package:flutter/material.dart';
import 'enlarge_image_page.dart';

class Classroom {
  final String name;
  final int capacity;
  final String imagePath;

  Classroom({
    required this.name,
    required this.capacity,
    required this.imagePath,
  });
}

class InfrastructurePage extends StatefulWidget {
  @override
  _InfrastructurePageState createState() => _InfrastructurePageState();
}

class _InfrastructurePageState extends State<InfrastructurePage> {
  final List<Classroom> classrooms = [
    Classroom(
      name: 'Clasroom-B1',
      capacity: 36,
      imagePath: 'assets/images/derslik_b1.png',
    ),
    Classroom(
      name: 'Clasroom-B2',
      capacity: 15,
      imagePath: 'assets/images/derslik_b2.png',
    ),
    Classroom(
      name: 'Clasroom-B3',
      capacity: 18,
      imagePath: 'assets/images/derslik_b3.png',
    ),
    Classroom(
      name: 'Clasroom-B4',
      capacity: 24,
      imagePath: 'assets/images/derslik_b4.png',
    ),
    Classroom(
      name: 'Clasroom-B5',
      capacity: 15,
      imagePath: 'assets/images/derslik_b5.png',
    ),
    Classroom(
      name: 'Clasroom-B6',
      capacity: 18,
      imagePath: 'assets/images/derslik_b6.png',
    ),
    Classroom(
      name: 'Clasroom-B7',
      capacity: 54,
      imagePath: 'assets/images/derslik_b7.png',
    ),
  ];

  final int maxCapacity = 54;

  EdgeInsets get _topSnackBarMargin => EdgeInsets.only(
    bottom: MediaQuery.of(context).size.height - 150,
    left: 10,
    right: 10,
  );

  // Shows a hint to the user about the double-tap functionality
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'HINT: Double tap to enlarge image. (You can also zoom/pan on the next screen.)',
          ),
          duration: Duration(seconds: 7),
          behavior: SnackBarBehavior.floating,
          margin: _topSnackBarMargin,
        ),
      );
    });
  }

  // Handles navigation to the image enlargement page
  void _enlargeImage(BuildContext context, String name, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EnlargeImagePage(imagePath: imagePath, title: name),
      ),
    );
  }

  // Builds the list view of classrooms with capacity indicators
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        final classroom = classrooms[index];

        final double capacityRatio = classroom.capacity / maxCapacity;

        return GestureDetector(
          onDoubleTap: () {
            _enlargeImage(context, classroom.name, classroom.imagePath);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: ListTile(
              title: Text(
                classroom.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              // Capacity Indicator
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Capacity: ${classroom.capacity}'),
                  SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: capacityRatio,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade600,
                    ),
                  ),
                ],
              ),

              trailing: Icon(Icons.chevron_right),
            ),
          ),
        );
      },
    );
  }
}
