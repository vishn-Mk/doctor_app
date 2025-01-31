import 'package:flutter/material.dart';



class TopDoctorsScreen extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Samira Ali',
      specialty: 'Dermatologist',
      location: 'Zamalek - Mohandessin',
      rating: 4.8,
      reviews: 1987,
      price: 600,
      image: 'asset/images/profile.png', // Replace with your image path
    ),
    Doctor(
      name: 'Dr. Hassan Mahmoud',
      specialty: 'Orthopedic Surgeon',
      location: 'New Cairo - Nasr City',
      rating: 4.7,
      reviews: 1755,
      price: 450,
      image: 'asset/images/profile.png', // Replace with your image path
    ),
    Doctor(
      name: 'Dr. Ahmed Khan',
      specialty: 'Cardiologist',
      location: 'Giza - Dokki - Maadi',
      rating: 4.9,
      reviews: 2435,
      price: 400,
      image: 'asset/images/profile.png', // Replace with your image path
    ),
    Doctor(
      name: 'Dr. Omar Khalefa',
      specialty: 'Pediatrician',
      location: '6th of October City',
      rating: 4.9,
      reviews: 350,
      price: 380,
      image: 'asset/images/profile.png', // Replace with your image path
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Doctors'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'See All',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
      ),
    );
  }
}

class Doctor {
  final String name;
  final String specialty;
  final String location;
  final double rating;
  final int reviews;
  final int price;
  final String image;

  Doctor({
    required this.name,
    required this.specialty,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.image,
  });
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                doctor.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(doctor.specialty),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16),
                      SizedBox(width: 4),
                      Expanded(child: Text(doctor.location)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text('${doctor.rating} (${doctor.reviews} Reviews)'),
                    ],
                  ),
                  Text(
                    '${doctor.price} EGP',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Icon(Icons.favorite, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
