import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:spy_project/models/myCategory.dart';

class DatabaseService {
  final CollectionReference categories = FirebaseFirestore.instance.collection('categories')
  .withConverter<MyCategory>(
    fromFirestore: (snapshot, _) => MyCategory.fromJson(snapshot.data()!),
      toFirestore: (category, _) => category.toJson());

  Future addCategory(MyCategory newCategory ) async {
    try{
      DocumentReference docRef = await categories.add(
        newCategory
      );
      return docRef;
    } catch(e) {
      print(e);
      return null;
    }
  }
  Future deleteCategory(String categoryId) async{
    try{
      return await categories.doc(categoryId).delete();
    } catch(e) {
      print(e);
      return null;
    }
  }
  Future addFieldToCategory(String field, String docId) async {
    try{
      DocumentSnapshot category = await categories.doc(docId).get();
      if(category.exists){
        MyCategory data = category.data()! as MyCategory;
        List fieldsList = data.fields!;
        fieldsList.add(field);
        try{
        return await categories
          .doc(docId).update({'fields': FieldValue.arrayUnion(fieldsList)});
        }catch(e){
          print(e);
        }
      }
    }catch(e){
      print(e);
    }
  }

  Future deleteFieldFromCategory(String field, String docId )async {
    try{
      DocumentSnapshot category = await categories.doc(docId).get();
      if(category.exists){
        List fieldsList = [];
        fieldsList.add(field);
        try{
        return await categories
          .doc(docId).update({'fields': FieldValue.arrayRemove(fieldsList)});
        }catch(e){
          print(e);
        }
      }
    }catch(e){
      print(e);
    }
  }


  final _categoriesRef = FirebaseFirestore.instance.collection('categories').withConverter<MyCategory>(
    fromFirestore: (snapshot, _) => MyCategory.fromJson(snapshot.data()!),
      toFirestore: (category, _) => category.toJson());
  Future getData() async {
    List<QueryDocumentSnapshot<MyCategory>> categories = await _categoriesRef
      //.where('name', isEqualTo: 'Countries')
      .get()
      .then((snapshot) => snapshot.docs);
    categories.forEach((element) {print(element.data().fields.toString());});
  }
  // Stream<List<MyCategory>> get categoriesStream {
  //   return categories.snapshots();
  // }


  // Future getCategories() async {
  //   QuerySnapshot querySnapshot = await categories.get();
  //   return querySnapshot.docs.map((doc) {
  //     return {
  //       doc.data(),
  //       doc.id
  //       };
  //     });
  // }
  
}