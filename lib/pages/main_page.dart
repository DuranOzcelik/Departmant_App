import 'package:flutter/material.dart';
import 'people_page.dart';
import 'infrastructure_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Department Application'),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'ABOUT'),
              Tab(text: 'PEOPLE'),
              Tab(text: 'INFRASTRUCTURE'),
              Tab(text: 'COURSES'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. ABOUT Tab Content
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About the Department',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome to the Department Application. Our mission is to provide high-quality education and research in the field of Computer Engineering, preparing students for the challenges of the global technology landscape.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      'Address: Main Campus, Engineering Faculty Building, Eskişehir',
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email: info@department.edu.tr'),
                  ),
                ],
              ),
            ),

            // 2. PEOPLE Tab Content
            PeoplePage(),

            // 3. INFRASTRUCTURE Tab Content
            InfrastructurePage(),

            // 4. COURSES Tab Content
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  'Current Semester Courses',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('BIM493 Mobile Programming I'),
                  subtitle: Text('Required - 6 ECTS'),
                ),
                ListTile(
                  title: Text('CSE201 Data Structures'),
                  subtitle: Text('Required - 5 ECTS'),
                ),
                ListTile(
                  title: Text('CSE350 Database Systems'),
                  subtitle: Text('Required - 6 ECTS'),
                ),
                ListTile(
                  title: Text('Elective 1: Introduction to AI'),
                  subtitle: Text('Elective - 3 ECTS'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
