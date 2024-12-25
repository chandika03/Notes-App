import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_app/app/routes/app_pages.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
        // backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // color: Colors.lightBlueAccent,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.noteTextController,
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Write your note here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Priority",
                style: Get.textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Priority',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: ['HIGH', 'MEDIUM', 'LOW']
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ))
                        .toList(),
                    value: controller.selectedValue.value,
                    onChanged: (String? value) {
                      controller.selectedValue.value = value;
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      width: size.width,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.noteTextController.text.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "Note cannot be empty!",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    if (controller.selectedValue.value == null) {
                      Get.snackbar(
                        "Error",
                        "Please select a priority!",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    GetStorage box = GetStorage();

                    var notes = box.read<List<dynamic>>('notes') ?? [];
                    var priorities = box.read<List<dynamic>>('priority') ?? [];
                    notes.insert(0, controller.noteTextController.text);
                    priorities.insert(0, controller.selectedValue.value);
                    box.write('notes', notes);
                    box.write('priority', priorities);

                    Get.offAllNamed(Routes.HOME);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Add Note",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
