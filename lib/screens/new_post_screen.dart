import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../model/food_waste_post.dart';


class NewPost extends StatefulWidget {
  final String imageURL;

  NewPost({Key key, this.imageURL}) : super(key: key);
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final formKey = GlobalKey<FormState>();
  final foodWastePostFields = FoodWastePost();
  LocationData locationData;
  
  @override
  void initState(){
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Number of items', border: OutlineInputBorder()),
                  onSaved: (value){
                    foodWastePostFields.numberOfItems = int.parse(value);
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please enter the number of items!';
                    }
                    else{
                      return null;
                    }
                  },       
                ),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: () {
                    foodWastePostFields.id = 0;
                    if(formKey.currentState.validate()){
                      formKey.currentState.save();
                      foodWastePostFields.dateTime = DateTime.now();
                      foodWastePostFields.latitude = locationData.latitude;
                      foodWastePostFields.longitude = locationData.longitude;
                      foodWastePostFields.imageURL = widget.imageURL;
                      saveToFileStore(foodWastePostFields);
                      Navigator.of(context).pop();
                    }

                  },
                  child: Text('Save Entry'),
                )
              ],
            ),
          )
        )
    );
  }

  void saveToFileStore(FoodWastePost foodWastePost){
    Firestore.instance.collection('testPosts').add({
      'date' : foodWastePostFields.dateTime,
      'id' : foodWastePostFields.id,
      'latitude' : foodWastePostFields.latitude,
      'longitude' : foodWastePostFields.longitude,
      'numberOfItems' : foodWastePostFields.numberOfItems,
      'imageURL' : foodWastePostFields.imageURL,
    });
  }

}
