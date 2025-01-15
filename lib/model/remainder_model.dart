import 'package:cloud_firestore/cloud_firestore.dart';

class RemainderModel{
  Timestamp? timestamp;
  bool? onOff;
  RemainderModel({
    this.timestamp,this.onOff
});
  Map<String, dynamic> toMap(){
    return{
      'time':timestamp,
      'onOff' : onOff,
    };
  }
  factory RemainderModel.fromMap(map){
    return RemainderModel(
      timestamp: map['time'],
      onOff: map['onOff']
    );
  }
}