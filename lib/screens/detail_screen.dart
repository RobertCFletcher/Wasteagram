import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final imageURL;
  final date;
  final numberOfItems;
  final latitude;
  final longitude;

  DetailScreen({Key key, this.imageURL, this.date, this.numberOfItems, this.latitude, this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Wasteagram')),
      ),
      body: Column(
        children: [
          Center(child: Padding(
            padding: EdgeInsets.all(30),
            child: Text(date, style: TextStyle(fontSize: 30),))
          ),
          Image.network(imageURL),
          Center(child: Padding(
            padding: EdgeInsets.all(30),
            child: Text('Items: $numberOfItems', style: TextStyle(fontSize: 30),))
          ),
          Center(child: Padding(
            padding: EdgeInsets.all(0),
            child: Text('$latitude, $longitude', style: TextStyle(fontSize: 30),))
          ),
        ],
      ),
    );
  }
}
