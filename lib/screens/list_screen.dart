import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import '../model/get_formatted_date.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int numberOfItems = 0;

  @override
  void initState() {
    super.initState();
    getNumberOfItems();
  }

  //https://stackoverflow.com/questions/52729497/whats-the-best-way-to-iterate-through-documents-on-a-firestore-collection-summi?rq=1
  void getNumberOfItems() async{
    Firestore.instance
        .collection('testPosts')
        .snapshots()
        .listen((snapshot) {
      int tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['numberOfItems']);
      setState(() {numberOfItems = tempTotal;});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(
          'Wasteagram - $numberOfItems')),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('testPosts').orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData || snapshot.data.documents.isEmpty){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(getFormattedDate(DateTime.fromMicrosecondsSinceEpoch(snapshot.data.documents[index]['date'].seconds * 1000000))),
                  trailing: Text(snapshot.data.documents[index]['numberOfItems'].toString()),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          imageURL: snapshot.data.documents[index]['imageURL'],
                          date: getFormattedDate(DateTime.fromMicrosecondsSinceEpoch(
                            snapshot.data.documents[index]['date'].seconds * 1000000)
                          ),
                          numberOfItems: snapshot.data.documents[index]['numberOfItems'],
                          latitude: snapshot.data.documents[index]['latitude'],
                          longitude: snapshot.data.documents[index]['longitude'],
                        ),
                      )
                    );
                    setState(() {});
                  },
                );
            });
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('cameraScreen');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
