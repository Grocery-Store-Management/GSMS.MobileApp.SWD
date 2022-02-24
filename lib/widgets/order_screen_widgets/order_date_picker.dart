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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: StartDateTextField(),
          ),
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: EndDateTextField(),
          ),
          SizedBox(
            child: ClearDateButton(),
          ),
        ],
      ),
    );
  }
}

class StartDateTextField extends StatefulWidget {
  const StartDateTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<StartDateTextField> createState() => _StartDateTextFieldState();
}

class _StartDateTextFieldState extends State<StartDateTextField> {
  TextEditingController dateInput = TextEditingController();

  //text editing controller for text field
  @override
  void initState() {
    dateInput.text = "";
    super.initState(); //set the initial value of text field
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateInput, //editing controller of this TextField
      decoration: InputDecoration(
          labelText: "Start Date"
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));
        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            dateInput.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}

class EndDateTextField extends StatefulWidget {
  const EndDateTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<EndDateTextField> createState() => _EndDateTextFieldState();
}

class _EndDateTextFieldState extends State<EndDateTextField> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    super.initState(); //set the initial value of text field
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateInput, //editing controller of this TextField
      decoration: InputDecoration(
          labelText: "End Date"
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));
        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            dateInput.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}

class ClearDateButton extends StatelessWidget {
  const ClearDateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: (ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20))),
      onPressed: () {},
      child: const Text("Clear"),
    );
  }
}
