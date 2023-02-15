import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class custom_card_payment extends StatelessWidget {
  String cardNumber;
  String cardHolder;
  String cardExpiration;
  String cvv;



  custom_card_payment({

    required this.cardNumber,
    required this.cardHolder,
    required this.cardExpiration,
  required this.cvv});

  factory custom_card_payment.fromJson(Map<String, dynamic> jsonData) {
    return custom_card_payment(
      cardNumber: jsonData['cardNumber'],
      cardHolder: jsonData['cardHolder'],
      cardExpiration: jsonData['cardExpiration'],
      cvv: jsonData['cvv'],
    );
  }

  static Map<String, dynamic> toMap(custom_card_payment card) => {
    'cardNumber': card.cardNumber,
    'cardHolder': card.cardHolder,
    'cardExpiration': card.cardExpiration,
    'cvv': card.cvv,
  };

  static String encode(List<custom_card_payment> card) => json.encode(
    card
        .map<Map<String, dynamic>>((card) => custom_card_payment.toMap(card))
        .toList(),
  );

  static List<custom_card_payment> decode(String card) =>
      (json.decode(card) as List<dynamic>)
          .map<custom_card_payment>((item) => custom_card_payment.fromJson(item))
          .toList();


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$cardNumber',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Row _buildLogosBlock() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Image.asset(
        "assets/images/contact_less.png",
        height: 20,
        width: 18,
      ),
      Image.asset(
        "assets/images/credit-card.png",
        height: 50,
        width: 50,
      ),
    ],
  );
}

Column _buildDetailsBlock({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        '$label',
        style: TextStyle(
            color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
      ),
      Text(
        '$value',
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      )
    ],
  );
}

