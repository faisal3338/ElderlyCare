
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../view_model/history_view_model.dart';

class History extends StatelessWidget {
  final controller = Get.put(HistoryViewModel());

  @override
  Widget build(BuildContext context) {
    controller.loadHistoryData();
    return Obx(() {
      return Scaffold(
          backgroundColor: Color.fromRGBO(175, 176, 200, 6),
          appBar: AppBar(
            title: Text('History ${controller.historyList.length}'),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[Colors.purple, Colors.blue])),
            ),
          ),
          body: ListView.builder(
              padding: EdgeInsets.all(1),
              itemCount: controller.historyList.length.toInt(),
              itemBuilder: (context, index) {
                print(controller.historyList.length.toInt());
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(15),
                      elevation: 10,

                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                            title: Text('Specialist: ${controller.historyList.value[index].specialist}'
                '\nUser: ${controller.historyList.value[index].user}'
                '\nmethod of payment: ${controller.historyList.value[index].paymentMethod} '
                '\nPaid up: ${controller.historyList.value[index].paidUp}'
                '\nDate:   ${DateFormat('dd-MM ').format( controller.historyList.value[index].dateTime)}'
                '\nTime: ${DateFormat(' hh:mm').format( controller.historyList.value[index].dateTime)}',
                style: TextStyle(fontWeight: FontWeight.bold)
                ),
                          ),

                        ],
                      ),

                    )
                  ],
                );
              }
          )

      );
    });
  }
}
