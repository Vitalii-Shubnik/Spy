import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:spy_project/models/myCategory.dart';
import 'package:spy_project/screens/home/Category.dart';
import 'package:spy_project/screens/home/NewCategoryAlert.dart';
import 'package:spy_project/services/database.dart';
import 'package:spy_project/shared/Loading.dart';
import 'package:spy_project/shared/constants.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    //final categories1 = DatabaseService().getData();
    final Stream<QuerySnapshot> _categories = FirebaseFirestore.instance.collection('categories').snapshots();
    //inal Stream<QuerySnapshot> _categories = Provider.of<Stream<QuerySnapshot>>(context);
    return StreamBuilder<QuerySnapshot?>(
      stream: _categories,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        return Scaffold(
          backgroundColor: secondaryDarkGreyColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ), 
            title: Text("Categories"),
            centerTitle: true,
            backgroundColor: mainDarkGreyColor,
          ),
          body:Container(
            padding: EdgeInsets.all(10),
            color: secondaryDarkGreyColor,
            child: Column(
            children:[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15.0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all<Color>(mainDarkGreyColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(width:2, color: accentRedColor),
                    )
                    )
                  ),
                  onPressed: (){newCategoryDialog(context,user.uid);},
                  child: Text('Add custom category',  style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child:ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  String id = document.id;
                  return Category(id: id, data: data);
                    // return ListTile(
                    //   textColor: Colors.white,
                    //   title: Text(data['name']),
                    //   subtitle: Text(data['fields'].toString()),
                    // );  
                  }).toList(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15.0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all<Color>(mainDarkGreyColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(width:2, color: accentRedColor),
                    )
                    )
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Save',  style: TextStyle(fontSize: 16,color: Colors.white)),
                ),
              ),
            ]
            ),
          )
        );
      },
    );
  }
}