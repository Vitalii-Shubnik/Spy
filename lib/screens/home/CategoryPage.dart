import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spy_project/models/myCategory.dart';
import 'package:spy_project/models/selectedFieldsList.dart';
import 'package:spy_project/screens/home/NewFIeldAlert.dart';
import 'package:spy_project/services/database.dart';
import 'package:spy_project/shared/Loading.dart';
import 'package:spy_project/shared/constants.dart';
import 'package:provider/provider.dart';
class CategoryPage extends StatefulWidget {
  final String id;
  CategoryPage({Key? key,required this.id}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    SelectedFields fields = Provider.of<SelectedFields>(context);
    final user = context.watch<User>();
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').doc(widget.id).snapshots(),
      builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting || (snapshot.hasData && !snapshot.data!.exists)){
          return Loading();
        }
        Map<String, dynamic> _data = snapshot.data!.data() as Map<String, dynamic>;
        
        return Scaffold( 
            backgroundColor: secondaryDarkGreyColor,
            appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ), 
                  title: Text(_data['name']),
                  centerTitle: true,
                  backgroundColor: mainDarkGreyColor,
                  actions: [
                    if(user.uid == _data['postedBy'])
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        DatabaseService().deleteCategory(snapshot.data!.id);
                      },
                    icon: Icon(Icons.delete, color: Colors.white,))
                  ],
                ),
            body: Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Column(
                children: <Widget>[
                  if(user.uid == _data['postedBy'])
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
                      onPressed: () async{
                        await newFieldDialog(context, snapshot.data!.id);
                        },
                      child: Text('Add custom field', style: TextStyle(fontSize: 16,color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _data['fields']!.length,
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 2,color: secondaryGreyColor,thickness: 2,),
                      itemBuilder: (BuildContext context, int index) {
                        bool? checked= false;
                        if(fields.includes(_data['fields']![index])){
                          checked = true;
                        }
                        return ListTile(
                          title:Text(_data['fields']![index], style: TextStyle(color: Colors.white)),
                          leading: Checkbox(
                            activeColor: accentRedColor,
                            value: checked,
                            onChanged: (bool? newVal){
                    
                              setState(() {
                                checked = newVal!;
                              });
                              if (newVal==true){
                                setState(() {
                                  fields.addField(_data['fields']![index]);
                                });
                              } else if(newVal==false){
                                setState(() {
                                  fields.removeField(_data['fields']![index]);
                                });
                              }
                              fields.printFields();
                            }
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle_outline, color: Colors.white,),
                            onPressed: ()async{await DatabaseService().deleteFieldFromCategory(_data['fields']![index], snapshot.data!.id);},
                           ),
                        );
                      },
                    ),
                  ),
                ]
              ),
            ),
          );
      },
    );
  }
}