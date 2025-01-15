import 'dart:async'; // Add this import for Timer
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification/controller/history_controller.dart';
import 'package:notification/model/history_model.dart';
import 'package:notification/screens/HomeScreen.dart';
import 'package:notification/screens/about_me_screen.dart';
import 'package:notification/screens/history_screen.dart';
import 'package:notification/utils/appColor.dart';
import 'package:notification/utils/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double defaultValue = 300;
  double value = 300.0;
  bool isStarted = false;
  bool isPaused = false;
  int focusedMins = 0;
  List<History> listHistory = [];
  Timer? _timer; // Updated to nullable Timer

  HistoryController historyController = HistoryController();
  TextEditingController purposeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: green1));
    HistoryController.init();
  }

  void startTimer() {
    if (purposeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a purpose before starting the timer.'),
        ),
      );
      return;
    }

    if (_timer != null && _timer!.isActive) return; // Prevent multiple timers

    focusedMins = value.toInt();
    setState(() {
      isStarted = true;
      isPaused = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused) {
        if (value <= 1) {
          stopTimer();
        } else {
          setState(() {
            value--;
          });
        }
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void stopTimer() {
    setState(() {
      _timer?.cancel();
      if (isStarted) {
        listHistory = historyController.read("history");
        listHistory.add(
          History(
            dateTime: DateTime.now(),
            focusedSecs: focusedMins,
            purpose: purposeController.text,
          ),
        );
        historyController.save("history", listHistory);
      }
      isStarted = false;
      isPaused = false;
      value = defaultValue;
      purposeController.clear();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Timer App'),
        backgroundColor: green1,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: green1),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Me'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) => const AboutMeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) => const HistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Remainder'),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: purposeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Purpose of Timer',
                    hintText: 'E.g., Studying, Working, etc.',
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 250,
                        child: Stack(
                          children: [
                            SleekCircularSlider(
                              initialValue: value,
                              min: 0,
                              max: 5401,
                              appearance: CircularSliderAppearance(
                                customWidths: CustomSliderWidths(
                                  trackWidth: 15,
                                  handlerSize: 20,
                                  progressBarWidth: 15,
                                  shadowWidth: 0,
                                ),
                                customColors: CustomSliderColors(
                                  trackColor: green1,
                                  progressBarColor: green4,
                                  hideShadow: true,
                                  dotColor: green4,
                                ),
                                size: 250,
                                angleRange: 360,
                                startAngle: 270,
                              ),
                              onChange: (newValue) {
                                setState(() {
                                  value = newValue;
                                });
                              },
                              innerWidget: (double newValue) {
                                return Center(
                                  child: Text(
                                    "${(value ~/ 60).toInt().toString().padLeft(2, '0')}:${(value % 60).toInt().toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      color: green1,
                                      fontSize: 46,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!isStarted) {
                              startTimer();
                            } else {
                              pauseTimer();
                            }
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppColors.primaryG,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.blackColor,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              !isStarted
                                  ? "START"
                                  : isPaused
                                  ? "RESUME"
                                  : "PAUSE",
                              style: TextStyle(
                                color: green4,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            stopTimer();
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppColors.secondaryG,
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.blackColor,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "STOP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
