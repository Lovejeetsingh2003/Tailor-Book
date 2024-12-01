import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tailor_book/colors.dart';
import 'package:tailor_book/config.dart';
import 'package:tailor_book/home/add_order_page.dart';
import 'package:tailor_book/objects/category_object.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  var gender = 0;
  var cleintGender = "";
  TextEditingController cleintNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  static Future<List<CategoryObject>> getCategory() async {
    List<CategoryObject> category = [];
    try {
      final res = await http.get(
        Uri.parse(getCategoryApi),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        if (data['data'] != null && data['data'] is List) {
          data['data'].forEach((value) {
            category.add(
              CategoryObject(
                id: value['_id'],
                categoryName: value['category_name'] ?? 'Unknown',
                categoryPic: value['category_pic'] ?? 'Unknown',
                categoryType: value['category_type'] ?? 'Unknown',
              ),
            );
          });
          return category;
        } else {
          print("No Category found");
          return [];
        }
      } else {
        print("Failed to load Category. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      print("error : $e");
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blue,
        centerTitle: true,
        title: const Text(
          "Tailor Book",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: cleintNameController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                hintText: "Cleint Name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              controller: phoneNoController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              decoration: const InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                icon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Select Gender :",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = 0;
                  });
                },
                child: Container(
                  height: 95,
                  width: 95,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: gender == 0 ? Colors.blue.shade300 : Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.male,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = 1;
                  });
                },
                child: Container(
                  height: 95,
                  width: 95,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: gender == 1 ? Colors.pink.shade300 : Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.female,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        "Female",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    gender = 2;
                  });
                },
                child: Container(
                  height: 95,
                  width: 95,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: gender == 2 ? Colors.yellow : Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.transgender,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        "Others",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          //Recomended Section
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: const Text("Cloth Type",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: blue,
                      letterSpacing: 0.5,
                    )),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            alignment: Alignment.center,
            height: 180,
            child: FutureBuilder(
              future: getCategory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<CategoryObject> list = snapshot.data;
                  return ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var category = list[index];
                      var categoryName = category.categoryName;
                      var image = category.categoryPic;
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.black),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: image!.startsWith('http')
                                    ? Image.network(
                                        image,
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Image.memory(
                                        base64Decode(image),
                                        height: 120,
                                        width: 120,
                                        fit: BoxFit.fitHeight,
                                      ),
                              ),
                              Text(
                                categoryName!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                if (gender == 0) {
                  cleintGender = "Male";
                } else if (gender == 1) {
                  cleintGender = "Female";
                } else {
                  cleintGender = "Others";
                }
                //check null or empty
                if (cleintNameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter the Cleint Name");
                } else if (phoneNoController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter the Phone Number");
                } else if (cleintGender == "") {
                  Fluttertoast.showToast(msg: "Select Cleint's Gender");
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddOrderPage(
                          // cleintName: cleintNameController.text.toString(),
                          // cleintPhoneNo: phoneNoController.text.toString(),
                          // cleintGender: cleintGender,
                          ),
                    ),
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 3),
                child: Text(
                  textAlign: TextAlign.center,
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
