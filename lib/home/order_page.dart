import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tailor_book/config.dart';
import 'package:tailor_book/home/add_order_page.dart';
import 'package:tailor_book/objects/order_object.dart';
import '../colors.dart';
import 'package:http/http.dart' as http;

import '../objects/category_object.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var list_length = 0;
  static Future<List<OrderObject>> getOrders() async {
    List<OrderObject> orders = [];

    try {
      final res = await http.get(
        Uri.parse(getOrderApi),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        if (data['data'] != null && data['data'] is List) {
          data['data'].forEach((value) {
            orders.add(
              OrderObject(
                id: value['_id'],
                clientName: value['client_name'] ?? 'Unknown',
                clientGender: value['client_gender'] ?? 'Unknown',
                clientAddress: value['client_address'] ?? 'No address provided',
                clientPhoneNumber: value['client_phone_number'] ?? 0,
                clothId: value['cloth_id'] ?? 'Unknown',
                clothCategoryId: value['cloth_category_id'] ?? 'Unknown',
                clothPic: value['cloth_pic'],
                clothCategoryPic: value['cloth_category_pic'],
                markUrgent: value['mark_urgent'] ?? false,
                measurementDressGiven:
                    value['measurement_dress_given'] ?? false,
                deliveryDate: value['delivery_date'] ?? 'Unknown',
                reminderDate: value['reminder_date'] ?? 'Unknown',
                upperLength: value['upper_length']?.toDouble() ?? 0.0,
                shoulder: value['shoulder']?.toDouble() ?? 0.0,
                chest: value['chest']?.toDouble() ?? 0.0,
                upperWaist: value['upper_waist']?.toDouble() ?? 0.0,
                upperHip: value['upper_hip']?.toDouble() ?? 0.0,
                gher: value['gher']?.toDouble() ?? 0.0,
                armLength: value['arm_length']?.toDouble() ?? 0.0,
                armLengthType: value['arm_length_type'] ?? 'Unknown',
                aroundArm: value['around_arm']?.toDouble() ?? 0.0,
                wrist: value['wrist']?.toDouble() ?? 0.0,
                collarFront: value['collar_front']?.toDouble() ?? 0.0,
                collarBack: value['collar_back']?.toDouble() ?? 0.0,
                lowerLength: value['lower_length']?.toDouble() ?? 0.0,
                lowerWaist: value['lower_waist']?.toDouble() ?? 0.0,
                lowerHip: value['lower_hip']?.toDouble() ?? 0.0,
                aroundLeg: value['around_leg']?.toDouble() ?? 0.0,
                mori: value['mori']?.toDouble() ?? 0.0,
                totalAmount: value['total_amount']?.toDouble() ?? 0.0,
                advancedAmount: value['advanced_amount']?.toDouble() ?? 0.0,
                dueAmount: value['due_amount']?.toDouble() ?? 0.0,
                specialInstruction: value['spc_instruction'],
              ),
            );
          });
          return orders;
        } else {
          print("No orders found");
          return [];
        }
      } else {
        print("Failed to load orders. Status code: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  //get category by id
  static Future<List<CategoryObject>> getCategoryById(String id) async {
    List<CategoryObject> category = [];

    // Create the request body with the category ID
    var categoryId = {"id": id};

    try {
      final res = await http.post(
        Uri.parse(getByIdCategoryApi),
        body: jsonEncode(categoryId),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
      );

      if (res.statusCode == 200) {
        // Parse the response body
        var data = jsonDecode(res.body);

        if (data['data'] != null && data['data'] is List) {
          // Map each item to a CategoryObject and add to the list
          data['data'].forEach((value) {
            category.add(
              CategoryObject(
                id: value['_id'],
                categoryName: value['category_name'] ?? 'Unknown',
                categoryPic: value['category_pic'] ?? '',
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
      print("Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
          color: white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AddOrderPage(),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          FutureBuilder(
            future: getOrders(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                List<OrderObject> list = snapshot.data;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: list.length,
                    (BuildContext context, int index) {
                      var order = list[index];
                      var name = order.clientName;
                      var phoneNo = order.clientPhoneNumber;
                      var deliveryDate = order.deliveryDate;
                      var clothCategoryPic = order.clothCategoryPic;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => AddOrderPage(
                                id: order.id,
                                clientName: order.clientName,
                                clientPhoneNo: order.clientPhoneNumber,
                                clientAddress: order.clientAddress,
                                clientGender: order.clientGender,
                                clothId: order.clothId,
                                clothCategoryId: order.clothCategoryId,
                                clothCategoryPic: order.clothCategoryPic,
                                deliveryDate: order.deliveryDate,
                                reminderDate: order.reminderDate,
                                isUrgent: order.markUrgent,
                                isDressGiven: order.measurementDressGiven,
                                upperLength: order.upperLength,
                                shoulder: order.shoulder,
                                chest: order.chest,
                                upperwaist: order.upperWaist,
                                upperHip: order.upperHip,
                                gher: order.gher,
                                armLength: order.armLength,
                                armLengthType: order.armLengthType,
                                aroundArm: order.aroundArm,
                                wrist: order.wrist,
                                collarFront: order.collarFront,
                                collarBack: order.collarBack,
                                lowerLength: order.lowerLength,
                                lowerWaist: order.lowerWaist,
                                lowerHip: order.lowerHip,
                                aroundLeg: order.aroundLeg,
                                mori: order.mori,
                                totalAmount: order.totalAmount,
                                advancedAmount: order.advancedAmount,
                                dueAmount: order.dueAmount,
                                spcInstruction: order.specialInstruction,
                                clothImage: order.clothPic,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: bgBlue,
                            border: Border.all(
                              width: 2,
                              style: BorderStyle.solid,
                              color: blue,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    name.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    phoneNo.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    deliveryDate.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: blue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: clothCategoryPic!.startsWith('http')
                                        ? Image.network(
                                            clothCategoryPic,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Image.memory(
                                            base64Decode(clothCategoryPic),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.fitHeight,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
