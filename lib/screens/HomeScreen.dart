import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/offer_provider.dart';

import '../wigets/category_card.dart';
import '../wigets/offer_card.dart';
import '../wigets/searchbar.dart';
import '../wigets/service_card.dart';
import '../wigets/bottomnavbar.dart';
import 'doctors.dart';
import 'login.dart'; // Import TopDoctorsScreen

class HomePage extends StatelessWidget {
  // Function to log out the user
  Future<void> logout(BuildContext context) async {
    try {
      // Clear the login status in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('isLoggedIn');
      prefs.remove('email');

      // Sign out from FirebaseAuth
      await FirebaseAuth.instance.signOut();

      // Redirect to the Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Redirecting to login page
      );
    } catch (e) {
      // Show an error message if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error logging out: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var offerProvider = Provider.of<OfferProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('asset/images/profile.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi, Mohamed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("How are you today?", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),  // Added logout icon
            onPressed: () => logout(context),  // Trigger the logout function
          ),
        ],
      ),
      body: SingleChildScrollView( // ✅ Added to prevent overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(),
              SizedBox(height: 20),
              Text("Our Services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceCard(icon: Icons.local_hospital, label: "Clinic appointment"),
                  ServiceCard(icon: Icons.video_call, label: "Online appointment"),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Offers", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      // Navigate to the "See All Offers" screen
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              offerProvider.offers.isNotEmpty
                  ? Column(
                children: List.generate(
                  offerProvider.offers.length,
                      (index) => OfferCard(
                    title: offerProvider.offers[index].title,
                    description: offerProvider.offers[index].description,
                    isClaimed: offerProvider.offers[index].isClaimed,
                    onClaim: () => offerProvider.claimOffer(index),
                    imageUrl: 'asset/images/doctor.jpg',
                  ),
                ),
              )
                  : Text("No active offers"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      // Navigate to the "See All Categories" screen
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              CategoryGrid(),
              SizedBox(height: 5), // Add space before doctors section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Doctors", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  TextButton(
                    onPressed: () {
                      // Navigate to the "See All Categories" screen
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Directly add TopDoctorsScreen content here
              Column(
                children: [
                  DoctorCard(
                    doctor: Doctor(
                      name: 'Dr. Samira Ali',
                      specialty: 'Dermatologist',
                      location: 'Zamalek - Mohandessin',
                      rating: 4.8,
                      reviews: 197,
                      price: 600,
                      image: 'asset/images/male.jpg',
                    ),
                  ),
                  DoctorCard(
                    doctor: Doctor(
                      name: 'Dr. Hassan Mahmoud',
                      specialty: 'Orthopedic Surgeon',
                      location: 'asset/images/male2.jpg',
                      rating: 4.7,
                      reviews: 155,
                      price: 450,
                      image: 'asset/images/profile.png',
                    ),
                  ),
                  DoctorCard(
                    doctor: Doctor(
                      name: 'Dr. Ahmed Khan',
                      specialty: 'Cardiologist',
                      location: 'Giza - Dokki - Maadi',
                      rating: 4.9,
                      reviews: 235,
                      price: 400,
                      image: 'asset/images/female2.jpg',
                    ),
                  ),
                  DoctorCard(
                    doctor: Doctor(
                      name: 'Dr. Omar Khalefa',
                      specialty: 'Pediatrician',
                      location: '6th of October City',
                      rating: 4.9,
                      reviews: 350,
                      price: 380,
                      image: 'asset/images/female3.jpg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
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
    return Card(color: Colors.white,elevation: 3,
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
