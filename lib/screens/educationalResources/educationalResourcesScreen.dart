import 'package:flutter/material.dart';

// This is the main widget for the Educational Resources screen
class EducationalResourcesScreen extends StatefulWidget {
  const EducationalResourcesScreen({Key? key}) : super(key: key);

  @override
  _EducationalResourcesScreenState createState() =>
      _EducationalResourcesScreenState();
}

// This is the state class for the Educational Resources screen
class _EducationalResourcesScreenState
    extends State<EducationalResourcesScreen> {
  // This list contains the educational resource information
  List<Map<String, String>> resources = [
    {
      'title': 'Healthy Eating Habits',
      'description':
          'Learn about the importance of a balanced diet and how to make healthy food choices.',
    },
    {
      'title': 'Exercise and Physical Activity',
      'description':
          'Discover the benefits of regular exercise and tips for incorporating physical activity into your daily routine.',
    },
    {
      'title': 'Stress Management Techniques',
      'description':
          'Explore various techniques for managing stress and promoting overall well-being.',
    },
    // Add more resources as needed
  ];

  // This is the build method that creates the UI for the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar title
      appBar: AppBar(
        title: Text('Educational Resources'),
      ),
      // Use a ListView.builder to display the list of resources
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              // Display the title and description of the resource
              title: Text(resources[index]['title']!),
              subtitle: Text(resources[index]['description']!),
              // Add an onTap callback to handle tapping on a resource
              onTap: () {
                // Navigate to a detailed resource page or show more information
              },
            ),
          );
        },
      ),
    );
  }
}
