import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification/model/remainder_model.dart';


class Switcher extends StatefulWidget {
  bool onOff;
  String uid;
  Timestamp timestamp;
  String id;

  Switcher(this.onOff,this.uid,this.id,this.timestamp);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    return Switch( onChanged:(bool value){
      RemainderModel remainderModel =RemainderModel();
      remainderModel.onOff =value;
      remainderModel.timestamp = widget.timestamp;
      FirebaseFirestore.instance.collection('users').doc(widget.uid).collection('reminder').doc(widget.id).update(remainderModel.toMap());

    },
      value: widget.onOff,
    );
  }
}
