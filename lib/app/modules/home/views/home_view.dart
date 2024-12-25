import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:notes_app/app/routes/app_pages.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.notes_rounded,
                size: 50,
                // color: Colors.lightBlueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'My Notes',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlueAccent,
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Saved Notes :",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Skeletonizer(
                enabled: false,
                child: Obx(
                  () => ListView.separated(
                    itemCount: controller.notes.length,
                    itemBuilder: (context, index) {
                      var note = controller.notes[index];
                      return Dismissible(
                        key: UniqueKey(),
                        child: Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.note_add_rounded,
                              size: 35,
                              color: Colors.lightBlue,
                            ),
                            title: Text(note['note'] ?? ' '),
                            trailing: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: (note['priority'] == 'HIGH')
                                    ? Colors.red
                                    : (note['priority'] == 'MEDIUM')
                                        ? Colors.yellow
                                        : Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_NOTE);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
