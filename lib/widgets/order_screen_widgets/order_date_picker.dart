import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDatePicker extends StatefulWidget {
  const OrderDatePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDatePicker> createState() => _OrderDatePickerState();
}

class _OrderDatePickerState extends State<OrderDatePicker> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  @override
  void initState() {
    startDate.text = "";
    endDate.text = "";
    super.initState(); //set the initial value of text field
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: TextField(
              controller: startDate, //editing controller of this TextField
              decoration: const InputDecoration(labelText: "Start Date"),
              readOnly: true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement
                  setState(() {
                    startDate.text = formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Start Date is not selected");
                }
              },
            ),
          ),
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: TextField(
              controller: endDate, //editing controller of this TextField
              decoration: const InputDecoration(labelText: "End Date"),
              readOnly: true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement
                  setState(() {
                    endDate.text = formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("End Date is not selected");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
