import 'dart:developer';
import 'package:attendance/Common/request.dart';
import 'package:attendance/Packages/flutter_glow/flutter_glow.dart';
import 'package:attendance/Utils/color.dart';
import 'package:attendance/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Packages/custom_dropdown/custom_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool stdList = false, fav = false;
  String year = '';
  TextEditingController search = TextEditingController(text: '');
  List<bool> checkBox = [];
  List<String> timeSlots = [
        "08:45:00 - 09:45:00",
        "04:00:00 - 05:00:00",
        "05:00:00 - 05:00:00",
        "12:00:00 - 13:00:00",
        "18:40:00 - 19:00:00"
      ],
      selectedSlots = [];
  @override
  void initState() {
    selectedSlots = [];
    checkBox = List.generate(timeSlots.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: mainColor,
          centerTitle: true,
          title: stdList
              ? Container(
                  width: width / 1.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.7)),
                  child: TextField(
                    controller: search,
                    decoration: const InputDecoration(
                      hintText: 'Search students',
                      icon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.search_rounded),
                      ),
                      border: InputBorder.none,
                    ),
                    autocorrect: true,
                    onChanged: (value) {},
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              : const Text(
                  'Attendance',
                  style: TextStyle(color: Colors.white),
                ),
        ),
        bottomSheet: Visibility(
          visible: stdList,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: textColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text('Submit')),
              ))
            ],
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Visibility(
              visible: !stdList,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Year',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade800),
                    ),
                    Container(
                      width: width,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: CustomDropdown(
                        decoration: const CustomDropdownDecoration(
                            headerStyle: TextStyle(fontSize: 15)),
                        items: const ["I", "II", "III", "IV"],
                        excludeSelected: true,
                        hintText: 'Select year',
                        onChanged: (data) {
                          setState(() {
                            year = data;
                          });
                          print(year);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: year.isNotEmpty && !stdList,
            child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(TextSpan(
                            text: 'Select Time Slots',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade800),
                            // children: [
                            // TextSpan(
                            //     text: !(checkBox.length <= 4)
                            //         ? "\nScroll to view other slots"
                            //         : "",
                            //     style: TextStyle(
                            //         fontSize: 13,
                            //         color: Colors.grey.shade600))
                            // ]
                          )),
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: textColor),
                              onPressed: () {
                                final now = DateTime.now();
                                if (checkBox.any((a) => a == true)) {
                                  setState(() {
                                    checkBox = List.generate(
                                      timeSlots.length,
                                      (index) => false,
                                    );
                                  });
                                } else {
                                  setState(() {
                                    selectedSlots.clear();
                                    checkBox = List.generate(timeSlots.length,
                                        (index) {
                                      final timeParts =
                                          timeSlots[index].split(' - ');
                                      final startTime = parseTime(timeParts[0]);

                                      if (startTime.isBefore(now)) {
                                        selectedSlots.add(timeSlots[index]);
                                        return true;
                                      }
                                      return false;
                                    });
                                  });
                                }
                              },
                              child: Text(
                                'Select All',
                                style: TextStyle(
                                    decorationColor: textColor,
                                    decoration: TextDecoration.combine(
                                        [TextDecoration.underline]),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ))
                        ],
                      ),
                      SizedBox(
                          height: checkBox.length <= 4 ? 200 : 300,
                          child: ListView.builder(
                            itemCount: timeSlots.length,
                            padding: const EdgeInsets.only(top: 10),
                            itemBuilder: (context, index) {
                              var time = timeSlots[index];
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Row(children: [
                                    GlowCheckbox(
                                      value: checkBox[index],
                                      color: textColor,
                                      onChange: (value) {
                                        final now = DateTime.now();
                                        final timeParts = time.split(' - ');
                                        final startTime =
                                            parseTime(timeParts[0]);
                                        if (startTime.isAfter(now)) {
                                          toast(text: "Not started timeslot");
                                        } else {
                                          setState(() {
                                            checkBox[index] = value;
                                            if (value) {
                                              selectedSlots.add(time);
                                            } else {
                                              selectedSlots.remove(time);
                                            }
                                          });
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(time,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade800)),
                                    )
                                  ]));
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  backgroundColor: textColor,
                                  foregroundColor: Colors.white),
                              onPressed: () async {
                                if (checkBox.any((e) => e == true)) {
                                  await Future.delayed(
                                    const Duration(milliseconds: 20),
                                    () => setState(() {
                                      stdList = true;
                                    }),
                                  );
                                } else {
                                  toast(text: 'Select any one slot');
                                }
                              },
                              child: const Text(
                                'Get Student List',
                              )),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red.shade500),
                              onPressed: () async {
                                if (checkBox.any((e) => e == true)) {
                                  await Future.delayed(
                                    const Duration(milliseconds: 20),
                                    () => setState(() {
                                      stdList = true;
                                      fav = true;
                                    }),
                                  );
                                } else {
                                  toast(text: 'Select any one slot');
                                }
                              },
                              icon: const Icon(CupertinoIcons.heart_fill),
                              label: const Text('Favourite List'))
                        ],
                      )
                    ])),
          ),
          Visibility(
              visible: stdList,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: fav
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            stdList = false;
                            fav = false;
                            selectedSlots.clear();
                            checkBox = List.generate(
                                timeSlots.length, (index) => false);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5, left: 12, right: 12),
                          child: Row(
                            children: [
                              Text("Change Time Slots    ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade900)),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: fav,
                        child: TextButton(
                            style: ElevatedButton.styleFrom(
                                foregroundColor: textColor),
                            onPressed: () {
                              final now = DateTime.now();
                              if (checkBox.any((a) => a == true)) {
                                setState(() {
                                  checkBox = List.generate(
                                    timeSlots.length,
                                    (index) => false,
                                  );
                                });
                              } else {
                                setState(() {
                                  selectedSlots.clear();
                                  checkBox =
                                      List.generate(timeSlots.length, (index) {
                                    final timeParts =
                                        timeSlots[index].split(' - ');
                                    final startTime = parseTime(timeParts[0]);

                                    if (startTime.isBefore(now)) {
                                      selectedSlots.add(timeSlots[index]);
                                      return true;
                                    }
                                    return false;
                                  });
                                });
                              }
                            },
                            child: Text(
                              'Select All',
                              style: TextStyle(
                                  decorationColor: textColor,
                                  decoration: TextDecoration.combine(
                                      [TextDecoration.underline]),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      selectedSlots.isEmpty
                          ? 'No slots selected'
                          : " ${selectedSlots.join(',  ')}  ",
                      style: TextStyle(
                          backgroundColor: Colors.white,
                          wordSpacing: 2.5,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                    ),
                  ),
                  SizedBox(
                    height: height - height / 4.5,
                    // color: Colors.green,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: timeSlots.length,
                        padding: const EdgeInsets.only(top: 15),
                        itemBuilder: (context, index) {
                          List<Color> loopColor = [
                            mainColor.withOpacity(.1),
                            Colors.white,
                          ];
                          return Container(
                            decoration: BoxDecoration(
                                color: loopColor[index % loopColor.length]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: width / 1.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Visibility(
                                        visible: fav,
                                        child: Icon(CupertinoIcons.heart_fill,
                                            color: Colors.red.shade500),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.5),
                                        child: Text('Name',
                                            style: TextStyle(fontSize: 12.5)),
                                      ),
                                      const Text('Name',
                                          style: TextStyle(fontSize: 12.5)),
                                      const Text('Year',
                                          style: TextStyle(fontSize: 12.5)),
                                    ],
                                  ),
                                ),
                                GlowCheckbox(
                                  color: textColor,
                                  value: checkBox[index],
                                  onChange: (value) {
                                    setState(() {
                                      checkBox[index] = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ))
        ]));
  }

  DateTime parseTime(String time) {
    final parsedTime = DateFormat('HH:mm:ss').parse(time);

    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, parsedTime.hour,
        parsedTime.minute, parsedTime.second);
  }
}
