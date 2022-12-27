import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';

import '../ modal/dbHelper.dart';

class YougotScreen extends StatefulWidget {
  const YougotScreen({Key? key}) : super(key: key);

  @override
  State<YougotScreen> createState() => _YougotScreenState();
}

class _YougotScreenState extends State<YougotScreen> {

  TextEditingController txtname = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  DbHelper db = DbHelper();

  void getData() async {
    homeController.productList.value = await db.productreadData(id:homeController.datapicker!.id!);
    homeController.addition();
    homeController.homeaddition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          elevation: 0,
          title: Text("Add Product",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Colors.white,fontSize: 18),
                textInputAction: TextInputAction.next,
                controller: txtname,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.person,color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900,width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white,fontSize: 18),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: txtamount,
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.currency_rupee,color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900,width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: txtdate,
                style: TextStyle(color: Colors.white,fontSize: 18),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Date",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: IconButton(onPressed: (){
                    datepickerDialogue();
                  },icon: Icon(Icons.calendar_month,color: Colors.grey),),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900,width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: txttime,
                style: TextStyle(color: Colors.white,fontSize: 18),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Time",
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: InkWell(
                      onTap: (){
                        Timepickerdialogue();
                      },
                      child: Icon(Icons.calendar_month,color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue.shade900,width: 3),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  db.productinsertData(txtname.text, txtamount.text, txtdate.text, txttime.text,int.parse(homeController.datapicker!.id!),0);
                  // homeController.addition();
                  // homeController.homeaddition();
                  getData();
                  Get.back();
                },
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void datepickerDialogue() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000));
    homeController.getData(date);
    if (date != null) {
      txtdate.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

  void Timepickerdialogue() async {
    TimeOfDay? t1 =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t1 != null) {
      DateTime parsedtime =
      DateFormat.jm().parse(t1.format(context).toString());

      String formetdtime = DateFormat('hh:mm').format(parsedtime);

      txttime.text = formetdtime;
    }
  }

}