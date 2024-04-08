import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:doctorapp/widgets/customButton.dart';
import 'package:doctorapp/widgets/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Address',
                  style: poppinsRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).disabledColor),
                ),
              ),
            ),
           const SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            MyTextField(
              maxLines: 3,
              capitalization: TextCapitalization.sentences,
              hintText: 'Enter Address',
              onTap: () => {},
              onChanged: (text) => {print(text)},
              onSubmit: () => {},
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
          buttonText: "Save",
          borderButton: false,
          width: Get.width * 0.9,
          height: Get.height * 0.08,
          // loading: load,
          onClick: () => {
            ScaffoldMessenger.of(context).showSnackBar(  const SnackBar(
              content: Text('Saved Successfully',
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
