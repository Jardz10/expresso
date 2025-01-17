import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoreHomeScreen extends StatefulWidget {
  static const routeName = '/StoreHomeScreen';
  @override
  _StoreHomeScreenState createState() => _StoreHomeScreenState();
}

class _StoreHomeScreenState extends State<StoreHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/images/Expresso Name Transparent Background.png'),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("stores").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final docs = snapshot.data.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, i) {
                      var latitude = docs[i]['latitude'].toString();
                      var longitude = docs[i]['longitude'].toString();
                      return ListTile(
                        title: Column(
                          children: [
                            Text('lat: $latitude'),
                            Text('long: $longitude'),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'StoreMenu');
                },
                child: Text("Edit Menu")
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('logout'),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }
}
