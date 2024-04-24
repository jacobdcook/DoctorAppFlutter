import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/dimentions.dart';
import 'package:doctorapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleDateTimeScreen extends StatelessWidget {
  const ScheduleDateTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Book Appointment'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'pickUpDate',
                style: poppinsBold.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.8),
                    fontSize: Dimensions.fontSizeLarge),
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_LARGE,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 100,
                    child: DatePicker(
                      DateTime.now(),
                      width: 100,
                      height: 100,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: ColorssA.primaryColor,
                      dateTextStyle: poppinsBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge20),
                      dayTextStyle: poppinsBold.copyWith(
                          letterSpacing: 1.5,
                          fontSize: Dimensions.fontSizeSmall),
                      monthTextStyle: poppinsRegular.copyWith(
                          letterSpacing: 1.5,
                          fontSize: Dimensions.fontSizeSmall),
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {},
                    ),
                  ),
                ],
              ),
              // scheduleTimeCalenderWidget(context),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_LARGE,
              ),
              Text(
                'pickUpTime',
                style: poppinsBold.copyWith(
                    color: Theme.of(context).hintColor.withOpacity(0.8),
                    fontSize: Dimensions.fontSizeLarge),
              ),

              const SizedBox(
                height: Dimensions.PADDING_SIZE_LARGE,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 4 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return pickTimeWidget(context, index, () {
                      // comonController.getPickedTime(index);
                    });
                  }),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Booed Succefully',
                        style: TextStyle(color: Colors.white)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: Get.width,
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                      color: ColorssA.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Book An Appointment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget pickTimeWidget(BuildContext context, int index, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.background,
        border: Border.all(color: Colors.transparent, width: 2),
        boxShadow: [
          BoxShadow(
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 6),
              color: Colors.black26.withOpacity(0.15))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.lock_clock),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '7:00AM - 9:00PM ',
                style: poppinsMedium.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimensions.fontSizeSmall),
              ),
              Text(
                'Home Timing',
                style: poppinsMedium.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimensions.fontSizeSmall),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
