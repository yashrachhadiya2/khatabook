import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khatabook/%20modal/dbHelper.dart';
import 'package:khatabook/%20modal/model.dart';
import 'package:khatabook/view/customerScreen.dart';
import '../controller/homeController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNumber = TextEditingController();

  TextEditingController utxtName = TextEditingController();
  TextEditingController utxtMobile = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    DbHelper db = DbHelper();
    homeController.stdList.value = await db.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("Contacts",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("All",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Khatabook",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 10),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "You will Give \n  0",
                      style: TextStyle(color: Colors.green),
                    ),
                    Text("You will Get \n  0",
                        style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "VIEW HISTORY >",
                  style: TextStyle(
                      color: Colors.blue.shade800,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            margin: EdgeInsets.all(5),
            height: 200,
            width: double.infinity,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                  itemCount: homeController.stdList.value.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        homeController.datapicker = Model(
                          name: homeController.stdList[index]['name'],
                          id: homeController.stdList[index]['id'].toString(),
                          mobile: homeController.stdList[index]['mobile'],
                        );
                        Get.to(CustomerScreen(  ));
                      },
                      child: ListTile(
                          leading: Text(
                              "${homeController.stdList.value[index]['id']}"),
                          title: Text(
                              "${homeController.stdList.value[index]['name']}"),
                          subtitle: Text(
                              "${homeController.stdList.value[index]['mobile']}"),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    DbHelper db = DbHelper();
                                    db.deleteData(
                                        '${homeController.stdList.value[index]['id']}');
                                    getdata();
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                IconButton(
                                    onPressed: () {
                                      utxtName = TextEditingController(
                                          text:
                                              "${homeController.stdList.value[index]['name']}");
                                      utxtMobile = TextEditingController(
                                          text:
                                              "${homeController.stdList.value[index]['mobile']}");
                                      Get.defaultDialog(
                                          content: Column(
                                        children: [
                                          TextField(
                                            controller: txtName,
                                            decoration:
                                                InputDecoration(hintText: "Name"),
                                          ),
                                          TextField(
                                            controller: txtNumber,
                                            decoration: InputDecoration(
                                                hintText: "Mobile"),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                DbHelper db = DbHelper();
                                                db.updateData(
                                                    '${homeController.stdList.value[index]['id']}',
                                                    utxtName.text,
                                                    utxtMobile.text);
                                                getdata();
                                              },
                                              child: Text("Submit"))
                                        ],
                                      ));
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                          )),
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            content: Column(
              children: [
                TextField(
                  controller: txtName,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: txtNumber,
                  decoration: InputDecoration(hintText: "Number"),
                ),
                ElevatedButton(
                    onPressed: () {
                      DbHelper db = DbHelper();
                      db.insertData(txtName.text, txtNumber.text);
                      getdata();
                      Get.back();
                    },
                    child: Text("Submit"))
              ],
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    ));
  }
}
