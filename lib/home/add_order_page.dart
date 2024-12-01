import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../colors.dart';
import '../config.dart';
import '../objects/category_object.dart';

class AddOrderPage extends StatefulWidget {
  final id,
      clientName,
      clientPhoneNo,
      clientGender,
      clientAddress,
      clothId,
      clothCategoryId,
      clothCategoryPic,
      deliveryDate,
      reminderDate,
      isUrgent,
      isDressGiven,
      upperLength,
      shoulder,
      chest,
      upperwaist,
      upperHip,
      gher,
      armLength,
      armLengthType,
      aroundArm,
      wrist,
      collarFront,
      collarBack,
      lowerLength,
      lowerWaist,
      lowerHip,
      aroundLeg,
      mori,
      totalAmount,
      advancedAmount,
      dueAmount,
      spcInstruction;

  const AddOrderPage(
      {this.id,
      this.clientName,
      this.clientPhoneNo,
      this.clientGender,
      this.clientAddress,
      this.clothId,
      this.clothCategoryId,
      this.clothCategoryPic,
      this.deliveryDate,
      this.reminderDate,
      this.upperLength,
      this.shoulder,
      this.chest,
      this.upperwaist,
      this.upperHip,
      this.isUrgent,
      this.isDressGiven,
      this.gher,
      this.armLength,
      this.armLengthType,
      this.aroundArm,
      this.wrist,
      this.collarFront,
      this.collarBack,
      this.lowerLength,
      this.lowerWaist,
      this.lowerHip,
      this.aroundLeg,
      this.mori,
      this.totalAmount,
      this.advancedAmount,
      this.dueAmount,
      this.spcInstruction,
      super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  var clientNameController = TextEditingController();
  var phoneNoController = TextEditingController();
  var clientAddressController = TextEditingController();
  var clothIdController = TextEditingController();
  var clothLengthController = TextEditingController();
  var clothShoulderController = TextEditingController();
  var clothChestController = TextEditingController();
  var clothWaistController = TextEditingController();
  var clothHipController = TextEditingController();
  var clothGherController = TextEditingController();
  var clothArmLengthController = TextEditingController();
  var clothAroundArmController = TextEditingController();
  var clothWristController = TextEditingController();
  var clothCollarFrontController = TextEditingController();
  var clothCollarBackController = TextEditingController();
  var bottomClothLengthController = TextEditingController();
  var bottomClothWaistController = TextEditingController();
  var bottomClothHipController = TextEditingController();
  var clothAroundLegController = TextEditingController();
  var clothMoriController = TextEditingController();
  var totalAmountController = TextEditingController();
  var advanceAmountController = TextEditingController();
  var dueAmountController = TextEditingController();
  var addInstructionController = TextEditingController();
  var deliveryDate = "Set Date";
  var _isUrgent = false;
  var _isDressGiven = false;
  var half = false;
  var upperClothType = "Upper Cloth Type";
  var lowerClothType = "Lower Cloth Type";
  var reminderDate = "Set Date";
  var armLength = "Half";
  var gender = 0;
  var clientGender = "";
  var clientType = 0;
  var selectedCategoryIndex = -1;
  var selectedCategoryId = "";
  var selectedCategoryPic = "";
  var dateFormat = DateFormat("dd-MMM-yyyy");
  var delShow = false;

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
    checkOrderData();
  }

  void addOrder() async {
    if (clientNameController.text.isNotEmpty &&
        phoneNoController.text.isNotEmpty &&
        clientAddressController.text.isNotEmpty &&
        clothIdController.text.isNotEmpty &&
        deliveryDate.isNotEmpty &&
        reminderDate.isNotEmpty &&
        clothLengthController.text.isNotEmpty &&
        clothShoulderController.text.isNotEmpty &&
        clothChestController.text.isNotEmpty &&
        clothWaistController.text.isNotEmpty &&
        clothHipController.text.isNotEmpty &&
        clothGherController.text.isNotEmpty &&
        clothArmLengthController.text.isNotEmpty &&
        clothAroundArmController.text.isNotEmpty &&
        armLength.isNotEmpty &&
        clothWristController.text.isNotEmpty &&
        clothCollarFrontController.text.isNotEmpty &&
        clothCollarBackController.text.isNotEmpty &&
        bottomClothLengthController.text.isNotEmpty &&
        bottomClothWaistController.text.isNotEmpty &&
        bottomClothHipController.text.isNotEmpty &&
        clothAroundLegController.text.isNotEmpty &&
        clothMoriController.text.isNotEmpty &&
        totalAmountController.text.isNotEmpty &&
        advanceAmountController.text.isNotEmpty &&
        dueAmountController.text.isNotEmpty) {
      var orderBody = {
        "client_name": clientNameController.text.toString(),
        "client_gender ": clientGender,
        "client_address": clientAddressController.text.toString(),
        "client_phone_number": phoneNoController.text.toString(),
        "cloth_id": clothIdController.text.toString(),
        "cloth_category_id": selectedCategoryId,
        // "cloth_pic": phoneNoController.text,
        "cloth_category_pic": selectedCategoryPic.toString(),
        "mark_urgent": _isUrgent,
        "measurement_dress_given": _isDressGiven,
        "delivery_date": deliveryDate.toString(),
        "reminder_date": reminderDate.toString(),
        "upper_length": clothLengthController.text.toString(),
        "shoulder": clothShoulderController.text.toString(),
        "chest": clothChestController.text.toString(),
        "upper_waist": clothWaistController.text.toString(),
        "upper_hip": clothHipController.text.toString(),
        "gher": clothGherController.text.toString(),
        "arm_length_type": armLength.toString(),
        "arm_length": clothArmLengthController.text.toString(),
        "around_arm": clothAroundArmController.text.toString(),
        "wrist": clothWristController.text.toString(),
        "collar_front": clothCollarFrontController.text.toString(),
        "collar_back": clothCollarBackController.text.toString(),
        "lower_length": bottomClothLengthController.text.toString(),
        "lower_waist": bottomClothWaistController.text.toString(),
        "lower_hip": clothHipController.text.toString(),
        "around_leg": clothAroundLegController.text.toString(),
        "mori": clothMoriController.text.toString(),
        "total_amount": totalAmountController.text.toString(),
        "advanced_amount": advanceAmountController.text.toString(),
        "due_amount": dueAmountController.text.toString(),
        "spc_instruction": addInstructionController.text.toString(),
      };

      try {
        var response = await http.post(
          Uri.parse(addOrderApi),
          body: jsonEncode(orderBody),
          headers: {"Content-Type": "application/json; charset=UTF-8"},
        );

        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          print("Message: $message");
          Fluttertoast.showToast(msg: "Order Added Successful");
          Navigator.pop(context);
        } else {
          print("Error : ${response.body}");
        }
      } catch (e) {
        print("error: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "some error occured or select all fields.");
    }
  }

  void checkOrderData() {
    if (widget.clientName == null &&
        widget.clientPhoneNo == null &&
        widget.clientGender == null &&
        widget.clientAddress == null &&
        widget.clothId == null &&
        widget.clothCategoryId == null &&
        widget.clothCategoryPic == null &&
        widget.deliveryDate == null &&
        widget.reminderDate == null &&
        widget.isUrgent == null &&
        widget.isDressGiven == null &&
        widget.upperLength == null &&
        widget.shoulder == null &&
        widget.chest == null &&
        widget.upperwaist == null &&
        widget.upperHip == null &&
        widget.gher == null &&
        widget.armLength == null &&
        widget.armLengthType == null &&
        widget.aroundArm == null &&
        widget.wrist == null &&
        widget.collarFront == null &&
        widget.collarBack == null &&
        widget.lowerLength == null &&
        widget.lowerWaist == null &&
        widget.lowerHip == null &&
        widget.aroundLeg == null &&
        widget.mori == null &&
        widget.totalAmount == null &&
        widget.advancedAmount == null &&
        widget.dueAmount == null &&
        widget.spcInstruction == null) {
      delShow = false;
      clientNameController.text = "";
      phoneNoController.text = "";
      gender = 0;
      clientAddressController.text = "";
      _isUrgent = false;
      _isDressGiven = false;
      selectedCategoryPic = "";
      deliveryDate = "";
      reminderDate = "";
      totalAmountController.text = "";
      advanceAmountController.text = "";
      dueAmountController.text = "";
      clothLengthController.text = "";
      clothShoulderController.text = "";
      clothChestController.text = "";
      clothWaistController.text = "";
      clothHipController.text = "";
      clothGherController.text = "";
      clothArmLengthController.text = "";
      armLength = "Half";
      clothAroundArmController.text = "";
      clothWristController.text = "";
      clothCollarFrontController.text = "";
      clothCollarFrontController.text = "";
      bottomClothLengthController.text = "";
      clothWaistController.text = "";
      clothHipController.text = "";
      clothAroundLegController.text = "";
      clothMoriController.text = "";
      addInstructionController.text = "";
    } else {
      delShow = true;
      // Set data to the respective fields
      clientNameController.text = widget.clientName ?? "";
      phoneNoController.text = widget.clientPhoneNo?.toString() ?? "";
      clothIdController.text = widget.clothId?.toString() ?? "";
      clientGender = widget.clientGender?.toString() ?? "";
      clientAddressController.text = widget.clientAddress ?? "";
      _isUrgent = widget.isUrgent ?? false;
      _isDressGiven = widget.isDressGiven ?? false;

      selectedCategoryPic = widget.clothCategoryPic;

      // Handle numeric or date fields
      deliveryDate = widget.deliveryDate?.toString() ?? "";
      reminderDate = widget.reminderDate?.toString() ?? "";
      totalAmountController.text = widget.totalAmount?.toString() ?? "0";
      advanceAmountController.text = widget.advancedAmount?.toString() ?? "0";
      dueAmountController.text = widget.dueAmount?.toString() ?? "0";

      // Measurements and instructions
      clothLengthController.text = widget.upperLength?.toString() ?? "";
      clothShoulderController.text = widget.shoulder?.toString() ?? "";
      clothChestController.text = widget.chest?.toString() ?? "";
      clothWaistController.text = widget.upperwaist?.toString() ?? "";
      clothHipController.text = widget.upperHip?.toString() ?? "";
      clothGherController.text = widget.gher?.toString() ?? "";
      clothArmLengthController.text = widget.armLength?.toString() ?? "";
      armLength = widget.armLengthType?.toString() ?? "";
      clothAroundArmController.text = widget.aroundArm?.toString() ?? "";
      clothWristController.text = widget.wrist?.toString() ?? "";
      clothCollarFrontController.text = widget.collarFront?.toString() ?? "";
      clothCollarBackController.text = widget.collarBack?.toString() ?? "";
      bottomClothLengthController.text = widget.lowerLength?.toString() ?? "";
      bottomClothWaistController.text = widget.lowerWaist?.toString() ?? "";
      bottomClothHipController.text = widget.lowerHip?.toString() ?? "";
      clothAroundLegController.text = widget.aroundLeg?.toString() ?? "";
      clothMoriController.text = widget.mori?.toString() ?? "";
      addInstructionController.text = widget.spcInstruction?.toString() ?? "";
    }
  }

// update Data

  void updateOrder() async {
    if (clientNameController.text.isNotEmpty &&
        phoneNoController.text.isNotEmpty &&
        clientAddressController.text.isNotEmpty &&
        clothIdController.text.isNotEmpty &&
        deliveryDate.isNotEmpty &&
        reminderDate.isNotEmpty &&
        clothLengthController.text.isNotEmpty &&
        clothShoulderController.text.isNotEmpty &&
        clothChestController.text.isNotEmpty &&
        clothWaistController.text.isNotEmpty &&
        clothHipController.text.isNotEmpty &&
        clothGherController.text.isNotEmpty &&
        clothArmLengthController.text.isNotEmpty &&
        clothAroundArmController.text.isNotEmpty &&
        armLength.isNotEmpty &&
        clothWristController.text.isNotEmpty &&
        clothCollarFrontController.text.isNotEmpty &&
        clothCollarBackController.text.isNotEmpty &&
        bottomClothLengthController.text.isNotEmpty &&
        bottomClothWaistController.text.isNotEmpty &&
        bottomClothHipController.text.isNotEmpty &&
        clothAroundLegController.text.isNotEmpty &&
        clothMoriController.text.isNotEmpty &&
        totalAmountController.text.isNotEmpty &&
        advanceAmountController.text.isNotEmpty &&
        dueAmountController.text.isNotEmpty) {
      var orderBody = {
        "id": widget.id,
        "client_name": clientNameController.text.toString(),
        "client_gender ": clientGender,
        "client_address": clientAddressController.text.toString(),
        "client_phone_number": phoneNoController.text.toString(),
        "cloth_id": clothIdController.text.toString(),
        "cloth_category_id": selectedCategoryId.toString(),
        // "cloth_pic": phoneNoController.text,
        "cloth_category_pic": selectedCategoryPic.toString(),
        "mark_urgent": _isUrgent,
        "measurement_dress_given": _isDressGiven,
        "delivery_date": deliveryDate.toString(),
        "reminder_date": reminderDate.toString(),
        "upper_length": clothLengthController.text.toString(),
        "shoulder": clothShoulderController.text.toString(),
        "chest": clothChestController.text.toString(),
        "upper_waist": clothWaistController.text.toString(),
        "upper_hip": clothHipController.text.toString(),
        "gher": clothGherController.text.toString(),
        "arm_length_type": armLength.toString(),
        "arm_length": clothArmLengthController.text.toString(),
        "around_arm": clothAroundArmController.text.toString(),
        "wrist": clothWristController.text.toString(),
        "collar_front": clothCollarFrontController.text.toString(),
        "collar_back": clothCollarBackController.text.toString(),
        "lower_length": bottomClothLengthController.text.toString(),
        "lower_waist": bottomClothWaistController.text.toString(),
        "lower_hip": clothHipController.text.toString(),
        "around_leg": clothAroundLegController.text.toString(),
        "mori": clothMoriController.text.toString(),
        "total_amount": totalAmountController.text.toString(),
        "advanced_amount": advanceAmountController.text.toString(),
        "due_amount": dueAmountController.text.toString(),
        "spc_instruction": addInstructionController.text.toString(),
      };

      try {
        var response = await http.post(
          Uri.parse(updateOrderApi),
          body: jsonEncode(orderBody),
          headers: {"Content-Type": "application/json; charset=UTF-8"},
        );

        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          print("Message: $message");
          Fluttertoast.showToast(msg: "Order Updated Successful");
          Navigator.pop(context);
        } else {
          print("Error : ${response.body}");
        }
      } catch (e) {
        print("error: $e");
      }
    } else {
      Fluttertoast.showToast(msg: "some error occured or select all fields.");
    }
  }

  void deleteOrder(id) async {
    var body = {
      "id": id,
    };
    try {
      var res = await http.post(
        Uri.parse(deleteOrderApi),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );

      if (res.statusCode == 200) {
        Fluttertoast.showToast(msg: "The Order successfully deleted");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Some error occur while deleting Order.");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  void showDeleteOrderDialog(
      BuildContext context, String clientName, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Order"),
          content: Text(
              "Are you sure you want to delete the Order of $clientName ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteOrder(widget.id);
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: white, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: delShow == false
          ? Container()
          : FloatingActionButton(
              backgroundColor: grey!,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.delete_outline,
                size: 30,
                color: white,
              ),
              onPressed: () {
                showDeleteOrderDialog(
                  context,
                  "${widget.clientName}",
                  () {
                    // Perform the delete action here
                    print("Category deleted");
                  },
                );
              },
            ),
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           if (cleintType == 1) {
                //             cleintType = 0;
                //           }
                //         });
                //       },
                //       child: Row(
                //         children: [
                //           cleintType == 0
                //               ? const Icon(
                //                   Icons.check_box,
                //                   size: 30,
                //                   color: blue,
                //                 )
                //               : const Icon(
                //                   Icons.check_box_outline_blank,
                //                   size: 30,
                //                   color: blue,
                //                 ),
                //           const Text(
                //             "New Cleint",
                //             style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500,
                //                 color: black),
                //           ),
                //         ],
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           if (cleintType == 0) {
                //             cleintType = 1;
                //           }
                //         });
                //       },
                //       child: Row(
                //         children: [
                //           cleintType == 1
                //               ? const Icon(
                //                   Icons.check_box,
                //                   size: 30,
                //                   color: blue,
                //                 )
                //               : const Icon(
                //                   Icons.check_box_outline_blank,
                //                   size: 30,
                //                   color: blue,
                //                 ),
                //           const Text(
                //             "Existing Cleint",
                //             style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500,
                //                 color: black),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                // ),

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  color: bgGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Client Details :",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: clientNameController,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Client Name",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          icon: const Icon(
                            Icons.person,
                            color: blue,
                            size: 30,
                          ),
                        ),
                      ),
                      TextField(
                        controller: phoneNoController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          icon: const Icon(
                            Icons.phone,
                            color: blue,
                            size: 30,
                          ),
                        ),
                      ),
                      TextField(
                        controller: clientAddressController,
                        keyboardType: TextInputType.streetAddress,
                        style: const TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Client Address",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          icon: const Icon(
                            Icons.location_on,
                            color: blue,
                            size: 30,
                          ),
                        ),
                      ),
                      TextField(
                        controller: clothIdController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Cloth Id",
                          hintStyle: TextStyle(
                            color: grey,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          icon: const Icon(
                            Icons.tag,
                            color: blue,
                            size: 30,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Select Client Gender :",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                                color: gender == 0
                                    ? Colors.blue.shade300
                                    : Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.black),
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
                                color: gender == 1
                                    ? Colors.pink.shade300
                                    : Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.black),
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
                                color:
                                    gender == 2 ? Colors.yellow : Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.black),
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
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  color: bgGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Cloth Type",
                            style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: grey,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Select Cloth Type :",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        alignment: Alignment.center,
                        height: 170,
                        child: FutureBuilder(
                          future: getCategory(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
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
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black),
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
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.fitHeight,
                                                )
                                              : Image.memory(
                                                  base64Decode(image),
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                        ),
                                        Text(
                                          categoryName!,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (selectedCategoryIndex ==
                                                  index) {
                                                selectedCategoryIndex = -1;
                                              } else {
                                                selectedCategoryIndex = index;
                                                selectedCategoryId =
                                                    list[selectedCategoryIndex]
                                                        .id!;
                                                selectedCategoryPic =
                                                    list[selectedCategoryIndex]
                                                        .categoryPic!;

                                                print(
                                                    "Category ID: ${selectedCategoryId}");
                                                print(
                                                    "Category Pic: ${selectedCategoryPic}");
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              selectedCategoryId ==
                                                      list[index].id
                                                  ? const Icon(
                                                      Icons.check_box,
                                                      size: 30,
                                                      color: blue,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .check_box_outline_blank,
                                                      size: 30,
                                                      color: blue,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            "Pattern Images :",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 70,
                            width: 100,
                            color: Colors.pink,
                          ),
                          Container(
                            height: 70,
                            width: 100,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "Delivery Date :",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          var formatDate = dateFormat.format(
                            date ?? DateTime.now(),
                          );
                          deliveryDate = formatDate;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                deliveryDate,
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                size: 30,
                                color: blue,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Text(
                            "Reminder Date :",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          var formatDate = dateFormat.format(
                            date ?? DateTime.now(),
                          );
                          reminderDate = formatDate;
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                reminderDate,
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                size: 30,
                                color: blue,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Mark As An Urgent",
                            style: TextStyle(
                              color: black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: _isUrgent,
                            activeTrackColor: Colors.lightBlue.shade200,
                            activeColor: blue,
                            onChanged: (value) {
                              setState(() {
                                _isUrgent = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "Add Measurement :",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Measurement Dress Given?",
                            style: TextStyle(
                              color: black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Switch(
                            value: _isDressGiven,
                            activeTrackColor: Colors.lightBlue.shade200,
                            activeColor: blue,
                            onChanged: (value) {
                              setState(() {
                                _isDressGiven = value;
                              });
                            },
                          ),
                        ],
                      ),

                      // upper cloth type

                      Row(
                        children: [
                          Text(
                            upperClothType,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: black,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      //length

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Length",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothLengthController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //shoulder
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Shoulder",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothShoulderController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //chest
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Chest",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothChestController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      //Waist
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Waist",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothWaistController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //Hip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Hip",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothHipController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //Gher
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Gher",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothGherController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //arm length
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Arm Length",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothArmLengthController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Arm Length Type",
                            style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Half",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                              Switch(
                                  value: (half),
                                  activeTrackColor: Colors.lightBlue.shade200,
                                  activeColor: blue,
                                  onChanged: (value) {
                                    setState(() {
                                      half = value;
                                      if (value == false) {
                                        armLength = "Full";
                                      } else {
                                        armLength = "Half";
                                      }
                                    });
                                  }),
                              const Text(
                                "Full",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                      //arm around
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Around Arm",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothAroundArmController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      //Wrist
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Wrist",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothWristController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //Collar Front
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Collar Front",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothCollarFrontController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // collar back
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Collar Back",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothCollarBackController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // bootom cloth type
                      Row(
                        children: [
                          Text(
                            lowerClothType,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: black,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      //length
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Length",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: bottomClothLengthController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Waist
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Waist",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: bottomClothWaistController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      //Hip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Hip",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: bottomClothHipController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // around leg
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Around Leg",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothAroundLegController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      // Mori
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Mori",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: clothMoriController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "00",
                                    hintStyle: TextStyle(
                                      color: grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "inc.",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Payment Status
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: bgGrey,
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Status",
                            style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // total amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 150,
                            child: Text(
                              "Total amount",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: totalAmountController,
                              style: const TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "00",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //advance amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 150,
                            child: Text(
                              "Advance Amount",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: advanceAmountController,
                              style: const TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "00",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //due amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 150,
                            child: Text(
                              "Due Amount",
                              style: TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: dueAmountController,
                              style: const TextStyle(
                                color: black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "00",
                                hintStyle: TextStyle(
                                  color: grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //special instruction
                Container(
                  color: bgGrey,
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Special Instruction",
                            style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 140,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: addInstructionController,
                          style: const TextStyle(
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: "Add Instructions",
                            hintStyle: TextStyle(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (clientNameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Client Name");
                      } else if (phoneNoController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Client Phone Number");
                      } else if (clientAddressController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Client Address");
                      } else if (clothIdController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the cloth Id");
                      } else if (deliveryDate == "set Date") {
                        Fluttertoast.showToast(msg: "Pick Delivery Date");
                      } else if (reminderDate == "set Date") {
                        Fluttertoast.showToast(msg: "Pick Reminder Date");
                      } else if (clothLengthController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Length");
                      } else if (clothShoulderController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Shoulder Length");
                      } else if (clothChestController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Chest Length");
                      } else if (clothWaistController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Waist Length");
                      } else if (clothHipController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Hip Length");
                      } else if (clothGherController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Gher Length");
                      } else if (clothArmLengthController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Arm Length");
                      } else if (armLength == "") {
                        Fluttertoast.showToast(msg: "Select Shoulder Length");
                      } else if (clothAroundArmController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Arm Around Length");
                      } else if (clothWristController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Wrist Length");
                      } else if (clothCollarFrontController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Collar Front Length");
                      } else if (clothCollarBackController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Collar Back Length");
                      } else if (bottomClothLengthController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Length Of Lower");
                      } else if (bottomClothWaistController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Waist Of Lower");
                      } else if (bottomClothHipController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Hip Of Lower");
                      } else if (clothAroundLegController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Around Leg Length");
                      } else if (clothMoriController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Mori Length");
                      } else if (totalAmountController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Total Amount");
                      } else if (advanceAmountController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Advance Amount");
                      } else if (dueAmountController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Due Amount");
                      } else {
                        clientGender = gender == 0
                            ? "Male"
                            : gender == 1
                                ? "Female"
                                : "Other";

                        if (widget.id == null &&
                            widget.clientName == null &&
                            widget.clientPhoneNo == null &&
                            widget.clientGender == null &&
                            widget.clientAddress == null &&
                            widget.clothId == null &&
                            widget.clothCategoryId == null &&
                            widget.clothCategoryPic == null &&
                            widget.deliveryDate == null &&
                            widget.reminderDate == null &&
                            widget.isUrgent == null &&
                            widget.isDressGiven == null &&
                            widget.upperLength == null &&
                            widget.shoulder == null &&
                            widget.chest == null &&
                            widget.upperwaist == null &&
                            widget.upperHip == null &&
                            widget.gher == null &&
                            widget.armLength == null &&
                            widget.armLengthType == null &&
                            widget.aroundArm == null &&
                            widget.wrist == null &&
                            widget.collarFront == null &&
                            widget.collarBack == null &&
                            widget.lowerLength == null &&
                            widget.lowerWaist == null &&
                            widget.lowerHip == null &&
                            widget.aroundLeg == null &&
                            widget.mori == null &&
                            widget.totalAmount == null &&
                            widget.advancedAmount == null &&
                            widget.dueAmount == null &&
                            widget.spcInstruction == null) {
                          addOrder();
                        } else {
                          updateOrder();
                        }
                      }
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 3),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Save",
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
          ),
        ),
      ),
    );
  }
}
