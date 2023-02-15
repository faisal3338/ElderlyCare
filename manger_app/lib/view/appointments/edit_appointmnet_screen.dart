import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_model/appointment_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class EditAppointmentScreen extends GetWidget<AppointmentViewModel> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  int appointmentIndex=0;

  EditAppointmentScreen(this.appointmentIndex);

  Widget build(BuildContext context) {

    controller.loadSpecialistsData();
    controller.textEditingController.clear();
    return Obx(() {
      return (Scaffold(
        backgroundColor: Color.fromRGBO(175, 176, 200, 6),
        appBar: AppBar(
            title: const Center(child: Text('Update appointments')),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.purple, Colors.blue])),
              // colors: <Color>[Color.fromRGBO(86,93,147,4), Color.fromRGBO(175,176,200, 6)])),
            )),
        body: ListView.builder(
            itemCount: controller.specialistList.length.toInt(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),

                      // color:Color.fromRGBO(86,93,147,4),
                      shadowColor: Colors.blueGrey,
                      elevation: 10,
                      borderOnForeground: true,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                            'Specialist name: ${controller.specialistList.value[index].name}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            'Phone: ${controller.specialistList.value[index].phoneNumber}'),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              CustomButton(
                                text: 'Update',
                                onPressed: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return Form(
                                          key: _globalKey,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx)
                                                        .viewInsets
                                                        .bottom +
                                                    20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //date
                                                TextFormField(
                                                    controller: controller
                                                        .textEditingController,
                                                    decoration: InputDecoration(
                                                        icon: Icon(Icons
                                                            .calendar_today), //icon of text field
                                                      labelText:
                                                      'Date: ${  DateFormat('dd-MM').format( controller.appointmentsList.value[index].dateTime)}\n'
                                                          'Time: ${  DateFormat('hh:mm').format( controller.appointmentsList.value[index].dateTime)}' //label text of field
                                                        ),
                                                    readOnly:
                                                        true, //set it true, so that user will not able to edit text
                                                    onTap: () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            2000), //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime(2101),
                                                      );

                                                      if (pickedDate != null) {
                                                        print(
                                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                        String formattedDate =
                                                            DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    pickedDate);
                                                        print(
                                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                                        //you can implement different kind of Date Format here according to your requirement

                                                        // controller.textEditingController.text=DateFormat('yyyy-MM-dd').format(controller.selectedDate.value).toString();

                                                        //time picker
                                                        TimeOfDay? pickedTime =
                                                            await showTimePicker(
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                          context: context,
                                                        );

                                                        if (pickedTime !=
                                                            null) {
                                                          print(
                                                              'the format is ${pickedTime.format(context)}'); //output 10:51 PM
                                                          DateTime parsedTime =
                                                              DateFormat.jm()
                                                                  .parse(pickedTime
                                                                      .format(
                                                                          context)
                                                                      .toString());
                                                          //converting to DateTime so that we can further format on different pattern.
                                                          print(
                                                              parsedTime); //output 1970-01-01 22:53:00.000
                                                          String formattedTime =
                                                              DateFormat(
                                                                      'HH:mm:ss')
                                                                  .format(
                                                                      parsedTime);
                                                          print(
                                                              formattedTime); //output 14:59:00
                                                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                          print(formattedDate);
                                                          final String
                                                              dateTimeString =
                                                              formattedDate +
                                                                  " " +
                                                                  formattedTime;
                                                          print(
                                                              'befor    $dateTimeString');
                                                          final DateFormat
                                                              format =
                                                              DateFormat(
                                                                  "yyyy-MM-dd hh:mm");
                                                          final DateTime
                                                              dateTime =
                                                              format.parse(
                                                                  dateTimeString);

                                                          print(
                                                              'the date isssssssssss ${dateTime.toString()}');
                                                          controller.dateTime =
                                                              dateTime;
                                                          controller
                                                                  .textEditingController
                                                                  .text =
                                                              '${formattedDate.toString()}  time: ${pickedTime.format(context)}';
                                                        } else {
                                                          print(
                                                              "Time is not selected");

                                                          validator:
                                                          validatePrice;
                                                        }

                                                        //time picker

                                                      } else {
                                                        print(
                                                            "Date is not selected");
                                                      }
                                                    }),

                                                const SizedBox(
                                                  height: 20,
                                                ),

                                                CustomTextFormField(
                                                  text: 'price',
                                                  hint:
                                                      '${controller.appointmentsList.value[appointmentIndex].price}',
                                                  onSave: (value) {
                                                    controller.price =
                                                        double.parse(value!);
                                                  },
                                                  validator: validatePrice,
                                                ),

                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                CustomButton(
                                                    text: 'Create',
                                                    onPressed: () {
                                                      print(controller.price);

                                                      _globalKey.currentState
                                                          ?.save();
                                                      if (_globalKey
                                                          .currentState!
                                                          .validate()) {
                                                        controller.updateAppointment(
                                                            controller
                                                                .specialistList
                                                                .value[index]
                                                                .specialistId,
                                                            controller
                                                                .specialistList
                                                                .value[index]
                                                                .name,controller.appointmentsList.value[index].appointmentId,
                                                            controller
                                                                .specialistList
                                                                .value[index]
                                                                .phoneNumber);
                                                        Get.back();
                                                        controller
                                                            .deleteOlderAppointments();
                                                        controller
                                                            .loadAppointmentsData();
                                                      }
                                                    }),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.refresh),
          onPressed: () {
            controller.loadSpecialistsData();
          },
        ),
      ));
    });
  }
}

String? validatePrice(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is empty";
  }
}

String? validateDate(String? value) {
  if (value == null || value.isEmpty) {
    return "This field is required";
  }
  int year;
  int month;
  if (value.contains(RegExp(r'(/)'))) {
    var split = value.split(RegExp(r'(/)'));

    month = int.parse(split[0]);
    year = int.parse(split[1]);
  } else {
    month = int.parse(value.substring(0, (value.length)));
    year = -1; // Lets use an invalid year intentionally
  }
  if ((month < 1) || (month > 12)) {
// A valid month is between 1 (January) and 12 (December)
    return 'Expiry month is invalid';
  }
  var fourDigitsYear = convertYearTo4Digits(year);
  if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
// We are assuming a valid should be between 1 and 2099.
// Note that, it's valid doesn't mean that it has not expired.
    return 'Expiry year is invalid';
  }
  if (!hasDateExpired(month, year)) {
    return "Card has expired";
  }
  return null;
}

int convertYearTo4Digits(int year) {
  if (year < 100 && year >= 0) {
    var now = DateTime.now();
    String currentYear = now.year.toString();
    String prefix = currentYear.substring(0, currentYear.length - 2);
    year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
  }
  return year;
}

bool hasDateExpired(int month, int year) {
  return isNotExpired(year, month);
}

bool isNotExpired(int year, int month) {
// It has not expired if both the year and date has not passed
  return !hasYearPassed(year) && !hasMonthPassed(year, month);
}

List<int> getExpiryDate(String value) {
  var split = value.split(RegExp(r'(/)'));
  return [int.parse(split[0]), int.parse(split[1])];
}

bool hasMonthPassed(int year, int month) {
  var now = DateTime.now();
// The month has passed if:
// 1. The year is in the past. In that case, we just assume that the month
// has passed
// 2. Card's month (plus another month) is more than current month.
  return hasYearPassed(year) ||
      convertYearTo4Digits(year) == now.year && (month < now.month + 1);
}

bool hasYearPassed(int year) {
  int fourDigitsYear = convertYearTo4Digits(year);
  var now = DateTime.now();
// The year has passed if the year we are currently is more than card's
// year
  return fourDigitsYear < now.year;
}
