import 'dart:io';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/color.dart';
import 'package:Riphah_CGPA_Calculator/Ui%20Helper/widget_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class addFacultyPage extends StatefulWidget {
  const addFacultyPage({super.key});

  @override
  State<addFacultyPage> createState() => _addFacultyPageState();
}

class _addFacultyPageState extends State<addFacultyPage> {
  File? pickedImage;
  bool isuploaded = false;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController qualificationController = TextEditingController();
    TextEditingController expertise1Controller = TextEditingController();
    TextEditingController expertise2Controller = TextEditingController();
    TextEditingController expertise3Controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Teacher"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () => showAlertBox(context),
                  child: pickedImage != null
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(pickedImage!),
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundColor: Color(Color_helper.background_color),
                          child: Icon(
                            Icons.camera_alt,
                            size: 80,
                            color: Color(Color_helper.button_color),
                          ),
                        ),
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Name",
                    prefixIcon: Icon(Icons.supervised_user_circle),
                  ),
                  controller: nameController,
                  validator: RequiredValidator(errorText: "Required"),
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined)),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value == '') {
                      return "Required";
                    } else if (!value.endsWith("@riphah.edu.pk")) {
                      return "Only Riphah Email";
                    }
                    return null;
                  },
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Qualification",
                      prefixIcon: Icon(Icons.queue_play_next_rounded)),
                  controller: qualificationController,
                  validator: RequiredValidator(errorText: "Required"),
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Expertise 1",
                      prefixIcon: Icon(Icons.exit_to_app_outlined)),
                  controller: expertise1Controller,
                  validator: RequiredValidator(errorText: "Required"),
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Expertise 2",
                      prefixIcon: Icon(Icons.exit_to_app_outlined)),
                  controller: expertise2Controller,
                ),
                WidgetHelper.customSizedBox(20),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Expertise 3",
                      prefixIcon: Icon(Icons.exit_to_app_outlined)),
                  controller: expertise3Controller,
                ),
                WidgetHelper.customSizedBox(20),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus!.unfocus();
                          try {
                            if (formKey.currentState!.validate()) {
                              final String date = DateTime.now().toString();
                              String url = '';

                              try {
                                UploadTask uploadTask = FirebaseStorage.instance
                                    .ref('Profile Pictures')
                                    .child(date)
                                    .putFile(pickedImage!);
                                TaskSnapshot taskSnapshot = await uploadTask;
                                url = await taskSnapshot.ref.getDownloadURL();
                              } catch (e) {
                                debugPrint('No Profile Picture');
                              }

                              await FirebaseFirestore.instance
                                  .collection('riphahFaculty')
                                  .doc(date)
                                  .set({
                                'teacherEmail': emailController.text.toString(),
                                'teacherName': nameController.text.toString(),
                                'teacherProfilePicture': url,
                                'teacherQualification':
                                    qualificationController.text.toString()
                              });

                              await FirebaseFirestore.instance
                                  .collection('riphahFaculty')
                                  .doc(date)
                                  .collection('expertise')
                                  .doc(date)
                                  .set({
                                'expertise1':
                                    expertise1Controller.text.toString(),
                                'expertise2':
                                    expertise2Controller.text.toString(),
                                'expertise3':
                                    expertise3Controller.text.toString()
                              });
                              pickedImage = null;
                              setState(() {});

                              WidgetHelper.custom_message_toast(
                                  context, 'Teacher Added');
                            }
                          } catch (e) {
                            WidgetHelper.custom_error_toast(
                                context, e.toString());
                          }
                        },
                        child: const Text("Add Teacher")))
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource,imageQuality: 40);
      if (photo == null) {
        File("path");
        return;
      }
      final tempPhoto = File(photo.path);
      setState(() {
        pickedImage = tempPhoto;
        debugPrint('pickImage : ${tempPhoto.toString()}');
      });
    } catch (ex) {
      debugPrint("ex: ${ex.toString()}");
    }
  }

  showAlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pick Image From"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.image),
                  title: const Text("Image"),
                )
              ],
            ),
          );
        });
  }
}
