import 'package:flutter/material.dart';

class Offer {
  final String title;
  final String description;
  bool isClaimed;

  Offer({required this.title, required this.description, this.isClaimed = false});
}

class OfferProvider with ChangeNotifier {
  List<Offer> _offers = [
    Offer(title: "Hello Doctor!", description: "50% off for your first video call with a doctor."),

  ];

  List<Offer> get offers => _offers;

  void claimOffer(int index) {
    _offers[index].isClaimed = true;
    notifyListeners();
  }
}
