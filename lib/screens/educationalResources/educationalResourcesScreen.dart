import 'package:flutter/material.dart';

class EducationalResourcesScreen extends StatefulWidget {
  const EducationalResourcesScreen({Key? key}) : super(key: key);

  @override
  _EducationalResourcesScreenState createState() =>
      _EducationalResourcesScreenState();
}

class _EducationalResourcesScreenState
    extends State<EducationalResourcesScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Resources'),
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(resources[index]['title']!),
              subtitle: Text(resources[index]['description']!),
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
