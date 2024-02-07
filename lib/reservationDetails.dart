import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  final String imageUrl;
  final String label;
  final double price;

  const Reservation({
    required this.imageUrl,
    required this.label,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.imageUrl),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Label: ${widget.label}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Price: ${widget.price}',
                  style: TextStyle(fontSize: 18),
                ),
                // Add more details here if needed
              ],
            ),
          ),
          // Add reservation form or button here
        ],
      ),
    );
  }
}
