
class FoodWastePost {
  int id;
  int numberOfItems;
  DateTime dateTime;
  double latitude;
  double longitude;
  String imageURL;

  String toString(){
    return 'id: $id, numberOfItems: $numberOfItems, time: $dateTime, latitude: $latitude, longitude: $longitude, imageURL: $imageURL';
  }
}