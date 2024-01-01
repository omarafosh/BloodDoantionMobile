import 'package:flutter/material.dart';



class InputDialog extends StatefulWidget {
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  TextEditingController input1Controller = TextEditingController();
  TextEditingController input2Controller = TextEditingController();
  TextEditingController input3Controller = TextEditingController();
  TextEditingController input4Controller = TextEditingController();

  @override
  void dispose() {
    input1Controller.dispose();
    input2Controller.dispose();
    input3Controller.dispose();
    input4Controller.dispose();
    super.dispose();
  }

  Future<void> _showInputAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Values'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: input1Controller,
                decoration: InputDecoration(labelText: 'Input 1'),
              ),
              TextFormField(
                controller: input2Controller,
                decoration: InputDecoration(labelText: 'Input 2'),
              ),
              TextFormField(
                controller: input3Controller,
                decoration: InputDecoration(labelText: 'Input 3'),
              ),
              TextFormField(
                controller: input4Controller,
                decoration: InputDecoration(labelText: 'Input 4'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog on cancel
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the entered values
                String value1 = input1Controller.text;
                String value2 = input2Controller.text;
                String value3 = input3Controller.text;
                String value4 = input4Controller.text;
                // Do something with the values
                print('Values: $value1, $value2, $value3, $value4');
                // Clear the text fields after processing
                input1Controller.clear();
                input2Controller.clear();
                input3Controller.clear();
                input4Controller.clear();
                Navigator.of(context).pop(); // Close the dialog on submit
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showInputAlertDialog(context); // Show the input dialog on button press
          },
          child: Text('Show Input Dialog'),
        ),
      ),
    );
  }
}
