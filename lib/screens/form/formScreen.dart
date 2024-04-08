import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:doctorapp/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/customButton.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  String? _selectedItem;
  List<String> items = [
    "Consultation",
    "Dental",
    "Heart",
    "Hospitals",
    "Medicals",
    "Physics",
    "Skin",
    "Surgeon",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Details'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Name',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            MyTextField(
              maxLines: 1,
              capitalization: TextCapitalization.sentences,
              hintText: 'Enter Name',
              onTap: () => {},
              onChanged: (text) => {print(text)},
              onSubmit: () => {},
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Email ID',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            MyTextField(
              maxLines: 1,
              capitalization: TextCapitalization.sentences,
              hintText: 'Enter EmailID',
              onTap: () => {},
              onChanged: (text) => {print(text)},
              onSubmit: () => {},
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Phone Number',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            MyTextField(
              maxLines: 1,
              capitalization: TextCapitalization.sentences,
              hintText: 'Phone Number',
              onTap: () => {},
              onChanged: (text) => {print(text)},
              onSubmit: () => {},
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Select Date',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.2))),
                height: MediaQuery.of(context).size.width * 0.14,
                child: Center(
                    child: TextField(
                  controller: dateInput,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                    } else {}
                  },
                ))),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Select Services',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Container(
              height: Get.height * 0.07,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: false,
                  isExpanded: true,
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      enabled: true,
                      value: value,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),

                          // width: Get.width,
                          child: Text(value)),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ButtonWight(
          buttonText: "Add Appointment",
          borderButton: false,
          width: Get.width * 0.9,
          height: Get.height * 0.08,
          // loading: load,
          onClick: () => {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Added Succefully',
          style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          )),
            Get.back(),
          },
        ),
      ),
    );
  }
}

Widget profileTabs(
    BuildContext context, String img, title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(
          left: 20, right: 20, bottom: Dimensions.PADDING_SIZE_DEFAULT),
      width: Get.width,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(5, 8),
                color: Colors.black26.withOpacity(0.1))
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Image.asset(
          //     img,width: 20,height: 20,
          //   ),
          // ),
          Text(
            title,
            style: poppinsMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).hintColor),
          ),
          Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Icon(Icons.arrow_forward_ios_outlined))
        ],
      ),
    ),
  );
}
