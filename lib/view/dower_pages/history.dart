
import 'package:elderlycare/view_model/history_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class History extends GetWidget<HistoryViewModel> {


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
                            title: Text('name: ${controller.historyList.value[index]
                                .specialist}'
                                '\nmethod: ${controller.historyList.value[index].paymentMethod} '
                                '\npaid up: ${controller.historyList.value[index].paidUp}'
                                '\ndate  ${DateFormat('dd-MM ').format( controller.historyList.value[index].dateTime)}'
                                '\ntime ${DateFormat(' hh:mm').format( controller.historyList.value[index].dateTime)}'
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
