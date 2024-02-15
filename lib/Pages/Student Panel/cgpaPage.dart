import 'package:Riphah_CGPA_Calculator/Functions/cgpaFunc.dart';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/color.dart';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CGPAPage extends StatefulWidget {
  const CGPAPage({super.key});

  @override
  State<CGPAPage> createState() => _CGPAPageState();
}

class _CGPAPageState extends State<CGPAPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController previousGPA = TextEditingController();
  TextEditingController previousCHrs = TextEditingController();
  TextEditingController newGPA = TextEditingController();
  TextEditingController newCHrs = TextEditingController();
  double CGPA = 0;

  isValid() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (formKey.currentState!.validate()) {
      final String pCH = previousCHrs.text.toString();
      final String pGPA = previousGPA.text.toString();
      final String nCHR = newCHrs.text.toString();
      final String nGPA = newGPA.text.toString();
      CGPA = calculateGPA(pCH, pGPA, nCHR, nGPA);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CGPA"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          // color: Color(Color_helper.background_color),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(CGPA > 1) WidgetHelper.customSizedBox(10),
                (CGPA > 1)
                    ? GPAGauge(cgpa: CGPA)
                    : WidgetHelper.customSizedBox(70),
                TextFormField(
                  controller: previousGPA,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: "Previous GPA",
                    prefixIcon: Icon(Icons.account_tree),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    if (!(double.parse(value) > 0 &&
                        double.parse(value) <= 4.0)) {
                      return "Invalid Value";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    if (!(double.parse(value) > 0 &&
                        double.parse(value) <= 200)) {
                      return "Invalid Value";
                    }
                    return null;
                  },
                  controller: previousCHrs,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: "Previous Cr.Hrs",
                    prefixIcon: Icon(Icons.lock_clock_outlined),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  controller: newGPA,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: "New SGPA",
                    prefixIcon: Icon(Icons.account_tree),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    if (!(double.parse(value) > 0 &&
                        double.parse(value) <= 4.0)) {
                      return "Invalid Value";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  controller: newCHrs,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                    labelText: "New Cr.Hrs",
                    prefixIcon: Icon(Icons.lock_clock_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    if (!(double.parse(value) > 0 &&
                        double.parse(value) <= 20)) {
                      return "Invalid Value";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                WidgetHelper.customSizedBox(20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(Color_helper.button_color),
                      // foregroundColor: Color(Color_helper.button_color),
                      padding: const EdgeInsets.all(16),
                      // side: BorderSide(
                      //     color: Color(Color_helper.button_color), width: 1),
                    ),
                    onPressed: isValid,
                    child: const Text(
                      "Calculate",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

class GPAGauge extends StatefulWidget {
  final double cgpa;
  const GPAGauge({super.key, required this.cgpa});

  @override
  State<GPAGauge> createState() => _GPAGaugeState();
}

class _GPAGaugeState extends State<GPAGauge> {

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      title: GaugeTitle(
          text: showMessage(widget.cgpa),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24,),
      ),
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 4,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 1,
              color: Colors.red,
            ),
            GaugeRange(
              startValue: 1,
              endValue: 2,
              color: Colors.yellow,
            ),
            GaugeRange(
              startValue: 2,
              endValue: 3,
              color: Colors.lightGreenAccent,
            ),
            GaugeRange(
              startValue: 3,
              endValue: 4,
              color: Colors.blue,
            )
          ],
          pointers: [
            NeedlePointer(
              value: widget.cgpa,
              enableAnimation: true,
            )
          ],
          annotations: [
            GaugeAnnotation(
              widget: (widget.cgpa > 0)
                  ? Text("CGPA: ${widget.cgpa.toStringAsFixed(3)}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                  : const Text(""),
              positionFactor: 0.5,
              angle: 90,
            ),
          ],
        ),
      ],
    );
  }
}
