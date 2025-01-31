import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"label": "Cardiology", "icon": Icons.favorite},
    {"label": "Neurology", "icon": Icons.grain},
    {"label": "Dermatology", "icon": Icons.abc_sharp},
    {"label": "Pulmonology", "icon": Icons.lens},
    {"label": "Surgery", "icon": Icons.lens_blur},
    {"label": "Nephrology", "icon": Icons.kitchen},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,  // Adjusted spacing between cards
        mainAxisSpacing: 10,   // Adjusted vertical spacing
        childAspectRatio: 1.5, // Adjusted to make the cards smaller
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return CategoryCard(
          label: categories[index]['label'],
          icon: categories[index]['icon'],
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;

  CategoryCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,  color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Reduced border radius
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0), // Reduced padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18, // Smaller icon size
              color: Colors.blue, // Optional, for icon color
            ),
            SizedBox(width: 10), // Reduced space between icon and label
            Text(
              label,
              style: TextStyle(
                fontSize: 12, // Smaller font size
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
