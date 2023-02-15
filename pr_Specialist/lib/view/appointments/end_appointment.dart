import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:specialist_app/view_model/appointment_view_model.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class EndAppointment extends GetWidget<AppointmentViewModel>{
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
int index;


EndAppointment(this.index);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(175,176,200, 6),
      appBar: AppBar(
        title: Text(
          'Bill'
        ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors:  <Color>[Colors.purple, Colors.blue])),
          )

      ),
      body: Column(
        children: [

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),

            // color:Color.fromRGBO(86,93,147,4),
            shadowColor: Colors.blueGrey,
            elevation: 10,
            margin: const EdgeInsets.all(9),
            borderOnForeground: true,
            child: Form(
              key: _globalKey,
              child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("  Specialist name:                                      ${controller.appointmentsList.value[index].specialist}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 2),
                    Text("  Price                                                          ${controller.appointmentsList.value[index].price}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 2),
                    Text("  Date                                                           ${ DateFormat('dd-MM').format( controller.appointmentsList.value[index].dateTime)}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 3),
                    Text("  Time                                                          ${  DateFormat('hh:mm').format( controller.appointmentsList.value[index].dateTime)}",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 3),
                    Text("  Duration                                                 2-hours ",style: TextStyle(fontSize: 17.0,)),
                    Divider(thickness: 3),
                    Text("  Payment Type                                            ${controller.appointmentsList.value[index].paymentMethod}",style: TextStyle(fontSize: 17.0,)),
                    SizedBox(height: 3,)
                  ,
                  CustomTextFormField(
                    text: '  The value',
                    hint: ('  ${controller.appointmentsList.value[index].price-double.parse(controller.appointmentsList.value[index].paidUp)}').toString() ,
                    onSave: (value) {
                      controller.paidUp=(double.parse(value!)+double.parse(controller.appointmentsList.value[index].paidUp)).toString();


                    },


                    validator: (value) {

                    },

                  ),
                ],
              ),

            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: 380,
            child: CustomButton(
              text: 'End the appointment',
              color: Colors.red,
              onPressed:(){

                _globalKey.currentState?.save();
                if(_globalKey.currentState!.validate()){
                  controller.remainder=double.parse(controller.paidUp)-controller.appointmentsList.value[index].price;
                  print('rrrrrrrrrrrrrrrrrr${controller.remainder}');

                  controller.updataUserwallet(controller.appointmentsList.value[index].userId,
                      controller.appointmentsList.value[index].price);
                  controller.paidUpAppointment(controller.appointmentsList.value[index].appointmentId);
                  controller.history(index);
                  Get.back();
                }
              },
            ),
          ),

        ],
      ),
    );

  }

}