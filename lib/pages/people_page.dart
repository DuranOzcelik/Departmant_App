import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Instructor {
  final String name;
  final String title;
  final String email;
  final String gsm;
  final String imagePath;

  Instructor({
    required this.name,
    required this.title,
    required this.email,
    required this.gsm,
    required this.imagePath,
  });
}

class PeoplePage extends StatelessWidget {
  final List<Instructor> instructors = [
    Instructor(
      name: 'Murat ÖZTÜRK',
      title: 'Dr. Öğr. Üyesi',
      email: 'murat.ozturk@eskisehir.edu.tr',
      gsm: '0505 412 87 36',
      imagePath: 'assets/images/murat_ozturk.png',
    ),
    Instructor(
      name: 'Emre KARAHAN',
      title: 'Doç. Dr.',
      email: 'emre.karahan@eskisehir.edu.tr',
      gsm: '0532 684 29 15',
      imagePath: 'assets/images/emre_karahan.png',
    ),
    Instructor(
      name: 'Hakan YILDIZ',
      title: 'Dr. Öğr. Üyesi',
      email: 'hakan.yildiz@eskisehir.edu.tr',
      gsm: '0541 297 63 82',
      imagePath: 'assets/images/hakan_yildiz.png',
    ),
    Instructor(
      name: 'Serkan DEMİRCİ',
      title: 'Prof. Dr.',
      email: 'serkan.demirci@eskisehir.edu.tr',
      gsm: '0554 318 40 27',
      imagePath: 'assets/images/serkan_demirci.png',
    ),
  ];

  // Launches the phone dialer with the instructor's number
  void _launchDialer(String phoneNumber) async {
    final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      print('Could not launch $dialUri');
    }
  }

  // Shows the confirmation dialog before placing a call
  void _showCallDialog(BuildContext context, Instructor instructor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dial a Number'),
          content: Text(
            'Would you like to call ${instructor.name}?\nGSM: ${instructor.gsm}',
          ),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _launchDialer(instructor.gsm);
              },
            ),
          ],
        );
      },
    );
  }

  // Builds the instructor card layout
  Widget _buildInstructorCard(BuildContext context, Instructor instructor) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            // Row: Photo and Information
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructor Photo
                ClipRect(
                  child: Image.asset(
                    instructor.imagePath,
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 100,
                        color: Colors.grey[200],
                        child: Icon(Icons.person, color: Colors.grey, size: 40),
                      );
                    },
                  ),
                ),
                SizedBox(width: 15),
                // Text Information Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Name
                      Text(
                        '${instructor.title} ${instructor.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      // Mail
                      Text(
                        'Mail: ${instructor.email}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      // GSM
                      Text(
                        'GSM: ${instructor.gsm}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12), // Spacer between info and button
            // Second Row: Call Button (Full Width)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('CALL'),
                onPressed: () {
                  _showCallDialog(context, instructor);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue.shade900,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the main list view of all instructors
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0, bottom: 0),
      itemCount: instructors.length,
      itemBuilder: (context, index) {
        return _buildInstructorCard(context, instructors[index]);
      },
    );
  }
}
