import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/color.dart';
import 'package:riphah_cgpa_calculator/Ui%20Helper/widget_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GPAScreen extends StatefulWidget {
  const GPAScreen({Key? key}) : super(key: key);

  @override
  State<GPAScreen> createState() => _GPAScreenState();
}

class _GPAScreenState extends State<GPAScreen> {
  @override
  void initState() {
    super.initState();
    subjectControllers = [];
    marksControllers = [];
    addSubject();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subjectControllers.map((e) => e.dispose());
    marksControllers.map((e) => e.dispose());
  }

  late List<TextEditingController> subjectControllers;
  late List<TextEditingController> marksControllers;

  final List<String> _creditPoints = ['1', '2', '3', '4'];

  final List<int> _selectedMarks = [];
  final List<String?> _selectedCreditPoints = [];
  double GPA = 0.0;
  bool showBottomResult = false;

  void addSubject() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (subjectControllers.length < 7) {
      _selectedMarks.add(0);
      _selectedCreditPoints.add(null);
      TextEditingController subjectController = TextEditingController();
      TextEditingController marksController = TextEditingController();
      subjectControllers.add(subjectController);
      marksControllers.add(marksController);
      setState(() {});
    } else {
      WidgetHelper.custom_error_toast(context, "Reached Maximum Courses");
      setState(() {
        showBottomResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "GPA CALCULATOR",
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _selectedMarks.length,
                itemBuilder: (context, index) {
                  return Slidable(
                      key: ValueKey(_selectedMarks[index]),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                              backgroundColor: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              autoClose: true,
                              icon: Icons.delete,
                              label: "Remove",
                              onPressed: (context) {
                                _selectedMarks.removeAt(index);
                                _selectedCreditPoints.removeAt(index);
                                subjectControllers.removeAt(index);
                                marksControllers.removeAt(index);
                                showBottomResult = false;
                                setState(() {});
                              })
                        ],
                      ),
                      child: SubjectRow(index));
                  // return SubjectRow(index);
                },
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {

                });
                showBottomResult = false;
                addSubject();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [10, 10],
                  color: Colors.grey,
                  strokeWidth: 2,
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xff154F7D),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Add Course",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                                color: Color(Color_helper.button_color)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus!.unfocus();
                bool isValid = validateAllFields();
                if (isValid) {
                  showBottomResult = true;
                  // setState(() {});

                  GPA = calculateGPA();

                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(Color_helper.button_color),
                  padding: const EdgeInsets.only(
                    left: 80,
                    right: 80,
                    top: 10,
                    bottom: 10,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: const Text(
                "Calculate",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
            if (showBottomResult)
              ButtomGPAComponent(_selectedCreditPoints, GPA),
          ],
        ),
      ),
    );
  }

  bool validateAllFields() {
    bool isValid = true;

    for (int i = 0; i < marksControllers.length; i++) {
      // Checking Marks Validation
      final String marksText = marksControllers[i].text;
      if (marksText.isEmpty) {
        WidgetHelper.custom_error_toast(
            context, "Marks Required in Subject ${marksControllers.length}");
        isValid = false;
      } else {
        final int? marks = int.tryParse(marksText);
        if (marks == null) {
          WidgetHelper.custom_error_toast(
              context, "Invalid Marks in Subject ${marksControllers.length}");
          isValid = false;
        } else if (marks == 0) {
          WidgetHelper.custom_error_toast(
              context, "Marks Required in Subject ${marksControllers.length}");
          isValid = false;
        } else if (marks < 0) {
          WidgetHelper.custom_error_toast(context,
              "Minimum Marks should be 0 in Subject ${marksControllers.length}");
          isValid = false;
        } else if (marks >= 100) {
          WidgetHelper.custom_error_toast(context,
              "Maximum Marks should be 100 in Subject ${marksControllers.length}");
          isValid = false;
        }
      }

      // Checking Grade Validation
      if (_selectedCreditPoints[i] == null) {
        WidgetHelper.custom_error_toast(
            context, "Select Grade of Subject ${i + 1}");
      }
    }

    return isValid;
  }

  double calculateGPA() {
    double sumGradePoints = 0;
    int sumCredits = 0;

    for (int i = 0; i < subjectControllers.length; i++) {
      int credit = int.parse(_selectedCreditPoints[i]!);
      int marks = int.parse(marksControllers[i].text);
      double gradePoint = calculateGradePoint(marks);

      sumGradePoints += credit * gradePoint;
      sumCredits += credit;
    }

    double result = sumGradePoints / sumCredits;
    GPA = result;
    // print("result-> $result");
    return result;
  }

  double calculateGradePoint(int marks) {
    double points = 0.0;
    if (marks >= 80) {
      points = 4.0;
    } else if (marks <= 50) {
      points = 0;
    } else {
      points = 1.0 + (marks - 50) * 0.1;
    }
    // print("point--> $gpa");
    return points;
  }

  Widget SubjectRow(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: subjectControllers[index],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                hintText: "Subject ${index + 1}",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50, // Set the height of the container
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        hintText: "Marks",
                      ),
                      onChanged: (value) {
                        marksControllers[index].text = value;
                        // print("Marks=> ${marksControllers[index].text}");
                        showBottomResult = false;
                        setState(() {});
                      },
                      controller: marksControllers[index],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48, // Set the height of the container
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: DropdownButton<String>(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 5),
                      isExpanded: true,
                      underline: Container(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      hint: const Text(
                        "Credit Hrs",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      value: _selectedCreditPoints.elementAt(index),
                      items: _creditPoints.map((credit) {
                        return DropdownMenuItem<String>(
                          value: credit,
                          child: Align(
                              alignment: Alignment.center, child: Text(credit)),
                        );
                      }).toList(),
                      onChanged: (selectedCredit) {
                        setState(() {
                          _selectedCreditPoints[index] = selectedCredit;
                          showBottomResult = false;
                          setState(() {});
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget ButtomGPAComponent(totalCr, selectedCreditPoints) {
  // print("totalCr: ${selectedCreditPoints.runtimeType}");
  // print("selectedCreditPoints: $selectedCreditPoints");
  try {
    String studentId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("Students")
        .doc(studentId)
        .update({"gpa": selectedCreditPoints.toStringAsFixed(2)});
  } catch (e) {
    debugPrint("Error on ButtonGPAComponent: ${e.toString()}");
  }

  var crHrs = totalCr.fold(0, (sum, cr) {
    if (cr == null) cr = '0';
    return sum + int.tryParse(cr);
  });
  return Column(
    children: [
      const Divider(),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Crd",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
                ),
                Text(
                  crHrs.toString(),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "GPA",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300),
                ),
                Text(
                  selectedCreditPoints.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}
