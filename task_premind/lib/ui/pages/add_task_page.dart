// ignore_for_file: unused_field

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_premind/models/categroies.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _tittleEditingController =
      TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];

  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appbar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create New Task',
                    style: Themes().titleStyle,
                  ),
                  const ImageIcon(
                    AssetImage('images/taskList.png'),
                    color: bluishClr,
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                'Task Name',
                style: Themes().titleStyle,
              ),
              const SizedBox(height: 10),
              inputField(
                  hintText: 'Task Name', controller: _tittleEditingController),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Select Category',
                    style: Themes().titleStyle,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See More',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount: Categroies.categroies.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  width: 130,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: check ? bluishClr : Colors.white,
                                    border: Border.all(
                                        width: 2.0,
                                        color:
                                            check ? Colors.white : Colors.blue,
                                        style: BorderStyle.solid),
                                  ),
                                  child: Text(
                                    Categroies.categroies[index],
                                    style: TextStyle(
                                      color:
                                          check ? Colors.white : Colors.black45,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                              onTap: () {
                                setState(() {
                                  check = !check;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 10),
              Text(
                'Date',
                style: Themes().titleStyle,
              ),
              const SizedBox(height: 10),
              inputField(
                  readOnly: true,
                  hintText:
                      DateFormat('dd-MM-yyyy').format(_selectedDate).toString(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => getDate(),
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: Themes().titleStyle,
                        ),
                        const SizedBox(height: 10),
                        inputField(
                            readOnly: true,
                            hintText: _startTime,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.timer),
                              onPressed: () => getTime(isStart: true),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: Themes().titleStyle,
                        ),
                        const SizedBox(height: 10),
                        inputField(
                            readOnly: true,
                            hintText: _endTime,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.timer),
                              onPressed: () => getTime(isStart: false),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Description',
                style: Themes().titleStyle,
              ),
              const SizedBox(height: 10),
              inputField(
                  hintText: 'Description', controller: _noteEditingController),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      valdidateDate();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryClr),
                      child: const Text(
                        'Create Task',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appbar() => AppBar(
          actions: const [
            ImageIcon(
              AssetImage('images/list.png'),
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            )
          ],
          elevation: 0,
          backgroundColor: context.theme.backgroundColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: primaryClr,
            ),
          ));
  addTasktoDB() async {
    int value = await _taskController.addTasks(
        task: Task(
            title: _tittleEditingController.text,
            note: _noteEditingController.text,
            isCompleted: 0,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            color: _selectedColor,
            remind: _selectedRemind,
            repeat: _selectedRepeat));

    print(value);
  }

  valdidateDate() {
    if (_tittleEditingController.text.isNotEmpty &&
        _noteEditingController.text.isNotEmpty) {
      addTasktoDB();
      Get.back();
    } else if (_tittleEditingController.text.isEmpty ||
        _noteEditingController.text.isEmpty) {
      Get.snackbar(
        'required',
        'All Fields are required !',
        margin: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        isDismissible: true,
      );
    } else {
      print('############ WARMING ############');
    }
  }

  Widget colorpalette() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: Themes().titleStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
              children: List.generate(
                  3,
                  (int? index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = index!;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            child: _selectedColor == index
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                : null,
                            backgroundColor: (index == 0)
                                ? primaryClr
                                : index == 1
                                    ? pinkClr
                                    : orangeClr,
                            radius: 15,
                          ),
                        ),
                      )))
        ],
      );

  getTime({required bool isStart}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStart
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String formatedtime = pickedTime!.format(context);

    if (isStart) {
      setState(() {
        _startTime = formatedtime;
      });
    } else if (!isStart) {
      setState(() {
        _endTime = formatedtime;
      });
    } else {
      print('time canceld or something wrong');
    }
  }

  getDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    } else {
      print('its null or something wrong');
    }
  }
}
