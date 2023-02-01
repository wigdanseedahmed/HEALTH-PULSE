///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';

String now = DateFormat("dd-MM-yyyy").format(DateTime.now());

class VaccinationAppoinmentInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(title: Text("Vaccination Appoinment")),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: MyCustomForm(),
      ),

      //Bottom Navigation Bar Starts
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFF38B6FF), width: 2),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: 30,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: 'Check-In',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: 'Statistics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ), //Bottom Navigation Bar Ends
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = new TextEditingController();
  TextEditingController dateinput = TextEditingController();
  final DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Make Your Appoinmnet Here',
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
          ),
          //Textfield 1 Starts Here
          SizedBox(
            width: 350,
            height: 16,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20.0))),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.person),
              hintText: 'Enter your Full Name ',
              labelText: 'Name',
            ),
          ),

          // Textfield 1 Ends Here

          // Textfield 2 Starts Here
          SizedBox(
            width: 350,
            height: 16,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20.0))),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.perm_identity),
              hintText: 'Enter your IC Number or Passport Number',
              labelText: 'Identity',
            ),
          ),
          //Textfield 2 Ends Here

          //Textfield 3 starts here
          SizedBox(
            height: 16,
            width: 350,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20.0))),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.add_location_sharp),
              hintText: 'Enter your Preferred Vaccination Location',
              labelText: 'Location',
            ),
          ),
          //Tetxfield 3 ends here

          //Textfield 4 starts here
          new SizedBox(
            height: 16,
            width: 350,
          ),
          TextFormField(
            controller: dateinput,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20.0))),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.calendar_today),
              hintText: ('Enter your preferred Appoinment Date'),
              labelText: 'Appointment Date',
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000, 1),
                  lastDate: DateTime(2101, 12));
              if (pickedDate != null) {
                print(pickedDate);
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                print(formattedDate);

                setState(() {
                  dateinput.text = formattedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          //Tetxfield 4 ends here

          //International Code Picker Starts Here
          new SizedBox(
            height: 16,
            width: 350,
          ),
          IntlPhoneField(
            initialCountryCode: 'MY',
            onChanged: (phone) {
              print(phone.countryCode);
              print(phone.number);
              print(phone.completeNumber);
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(20))),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.local_phone),
              hintText: 'Enter your Phone Number',
              labelText: 'Phone Number',
            ),
          ),
          //International Code Picker Ends here

          new Container(
              padding: const EdgeInsets.all(20),
              child: new ElevatedButton.icon(
                icon: Icon(Icons.calendar_month),
                label: Text('Save Appointment'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(190, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
              )),
        ],
      ),
    );
  }
}
