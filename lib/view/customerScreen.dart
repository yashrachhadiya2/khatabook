import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khatabook/view/yougaveScreen.dart';
import 'package:khatabook/view/yougotScreen.dart';

import '../ modal/dbHelper.dart';
import '../controller/homeController.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNumber = TextEditingController();

  TextEditingController utxtName = TextEditingController();
  TextEditingController utxtMobile = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  DbHelper db = DbHelper();

  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    homeController.productList.value = await db.productreadData(id: homeController.datapicker!.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call),
            ),
          ],
          title: Text("${homeController.datapicker!.name}"),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 10),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Income",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          Text(
                            "💲 0",
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Expense",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          Text(
                            "💲 0",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              margin: EdgeInsets.all(5),
              height: 150,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Date/Time"),
                Text("Remark"),
                Text("You Gave|You Got"),
              ],
            ),
            Obx(
                  () => Expanded(
                child: ListView.builder(
                    itemCount: homeController.productList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){

                        },
                        child: ListTile(
                            leading: Text(
                                "${homeController.productList.value[index]['id']}"),
                            title: Text(
                                "${homeController.productList.value[index]['name']}"),
                            subtitle: Text(
                                "${homeController.productList.value[index]['mobile']}"),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  // IconButton(
                                  //   onPressed: () {
                                  //     DbHelper db = DbHelper();
                                  //     db.deleteData(
                                  //         '${homeController.stdList.value[index]['id']}');
                                  //     getdata();
                                  //   },
                                  //   icon: Icon(Icons.delete),
                                  // ),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       utxtName = TextEditingController(
                                  //           text:
                                  //           "${homeController.stdList.value[index]['name']}");
                                  //       utxtMobile = TextEditingController(
                                  //           text:
                                  //           "${homeController.stdList.value[index]['mobile']}");
                                  //       Get.defaultDialog(
                                  //           content: Column(
                                  //             children: [
                                  //               TextField(
                                  //                 controller: txtName,
                                  //                 decoration:
                                  //                 InputDecoration(hintText: "Name"),
                                  //               ),
                                  //               TextField(
                                  //                 controller: txtNumber,
                                  //                 decoration: InputDecoration(
                                  //                     hintText: "Mobile"),
                                  //               ),
                                  //               ElevatedButton(
                                  //                   onPressed: () {
                                  //                     DbHelper db = DbHelper();
                                  //                     db.updateData(
                                  //                         '${homeController.stdList.value[index]['id']}',
                                  //                         utxtName.text,
                                  //                         utxtMobile.text);
                                  //                     getdata();
                                  //                   },
                                  //                   child: Text("Submit"))
                                  //             ],
                                  //           ));
                                  //     },
                                  //     icon: Icon(Icons.edit))
                                ],
                              ),
                            )),
                      );
                    }),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(YougaveScreen());
                        },
                        child: Text(
                          "YOU GAVE",
                        )),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(YougotScreen());
                        },
                        child: Text(
                          "YOU GOT",
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
