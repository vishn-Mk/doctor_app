import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isClaimed;
  final VoidCallback onClaim;
  final String imageUrl; // New parameter for image

  OfferCard({
    required this.title,
    required this.description,
    required this.isClaimed,
    required this.onClaim,
    required this.imageUrl, // Required image URL
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,  color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 5),
                  Text(description),
                  SizedBox(height: 10),
                  isClaimed
                      ? Text("Offer claimed!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                      : ElevatedButton(
                    onPressed: onClaim,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Set button color to blue
                      foregroundColor: Colors.white, // Set text color to white
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("Get offer"),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded corners for the image
              child: Image.asset(
                imageUrl, // Use the provided image URL
                width: 100,
                height: 120,
                fit: BoxFit.cover, // Ensures the image fills the space properly
              ),
            ),
          ],
        ),
      ),
    );
  }
}
