import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

deleteRemainder(BuildContext context, String id, String uid){
  return showDialog(
    context: context,
    builder :(context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          
        ),
        title: Text("delete remaider"),
        content: Text('Are you sure you want to delete'),
        actions: [
          TextButton(onPressed: (){
            try{
              FirebaseFirestore.instance.collection("users").doc(uid).collection("reminder").doc(id).delete();

              Fluttertoast.showToast(msg: "Remaider delete");
            } catch(e){
              Fluttertoast.showToast(msg:e.toString() );
            }
            Navigator.pop(context);
          }, child: Text("Delete")),
          TextButton(onPressed: (){
            Navigator.pop(context);


          }, child:Text("cancel"))
        ],
        
      );
    }
  );
}