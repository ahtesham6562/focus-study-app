import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notification/model/remainder_model.dart';
import 'package:notification/utils/appColor.dart';

Future<void> addRemainder(BuildContext context, String uid) async {
  TimeOfDay time = TimeOfDay.now();

  void add(String uid, TimeOfDay time) async {
    try {
      DateTime d = DateTime.now();
      DateTime dateTime = DateTime(d.year, d.month, d.day, time.hour, time.minute);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      RemainderModel remainderModel = RemainderModel();
      remainderModel.timestamp = timestamp;
      remainderModel.onOff = false;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(remainderModel.toMap());

      Fluttertoast.showToast(msg: "Remainder Added");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: Text('Add Remainder'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Select a time for Remainder'),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (newTime == null) return;
                      setState(() {
                        time = newTime;
                      });
                    },
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: AppColors.primaryColor1,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          time.format(context),
                          style: TextStyle(
                            color: AppColors.primaryColor1,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  add(uid, time);
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
