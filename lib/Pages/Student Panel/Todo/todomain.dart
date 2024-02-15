import 'package:Riphah_CGPA_Calculator/Functions/todoMainPageFun.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class TodoMainPage extends StatelessWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo Tasks"),
        ),
        body: readData(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final taskKey = GlobalKey<FormState>();
                TextEditingController titleController = TextEditingController();
                TextEditingController descController = TextEditingController();
                return AlertDialog(
                  title: const Text("Enter Task"),
                  content: Form(
                    key: taskKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: const Text("Subject Name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: RequiredValidator(errorText: "Required"),
                          controller: titleController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: const Text("Subject Description"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: RequiredValidator(errorText: "Required"),
                          controller: descController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                            onPressed: () {
                              createFunc(titleController, descController, taskKey, context);
                            },
                            child: const Text("Add Task"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
    );
  }
}