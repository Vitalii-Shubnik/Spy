import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spy_project/models/selectedFieldsList.dart';
import 'package:spy_project/screens/home/CategoryPage.dart';
import 'package:spy_project/shared/constants.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  final String id;
  Map<String,dynamic> data;
  Category({Key? key, required this.id, required this.data}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  
  @override
  Widget build(BuildContext context) {
    bool? checked = false;
    SelectedFields fields = Provider.of(context);
    if(fields.includesEvery(widget.data['fields'])&& widget.data['fields'].length>0){
      checked = true;
    }
    final user = context.watch<User>();
    return Container(
      padding: EdgeInsets.fromLTRB(0,5,0,5),
      child: Container(
        padding: EdgeInsets.fromLTRB(10,0,10,0),
        decoration: BoxDecoration(
          color: widget.data['free'] == false ? secondaryGreyColor : secondaryDarkGreyColor,
          borderRadius: BorderRadius.circular(6.0),
          border: widget.data['postedBy'] == user.uid? Border.all(color: accentRedColor, width: 2) : Border.all(color: Colors.white, width: 2)
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Row(
              children:<Widget>[ Checkbox(
                activeColor: accentRedColor,
                value: checked,
                onChanged: (bool? newVal){
                  if(widget.data['free']==true){
                    setState(() {
                    checked = newVal!;
                    });
                    if (newVal==true){
                      setState(() {
                        fields.addFields(widget.data['fields']);
                      });
                    } else if(newVal==false){
                      setState(() {
                        fields.removeFields(widget.data['fields']);
                      });
                    }
                  }
                  fields.printFields();
                }
              ),
              Text(widget.data['name'], style: TextStyle(fontSize: 16,color: Colors.white),),
              ]
            ),
              
            Row(children: [
              if( widget.data['free'] == false) 
                IconButton(
                  color: mainDarkGreyColor,
                  padding: EdgeInsets.all(8),
                  onPressed: (){
                    
                  },
                  icon: Icon(Icons.lock, size: 20,),
                ),
              Text('${fields.countMatches(widget.data['fields'])} | ${widget.data['fields'].length.toString()}', style: TextStyle(fontSize: 16,color: Colors.white)),
              IconButton(
                color: mainDarkGreyColor,
                padding: EdgeInsets.all(8),
                onPressed: (){
                  if(widget.data['free'] == true)
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>CategoryPage(id: widget.id))
                  );
                },
                icon: Icon(Icons.arrow_forward, size: 30,),
              ),
            ],)
          ]
          ),
      ),
    );
  }
}