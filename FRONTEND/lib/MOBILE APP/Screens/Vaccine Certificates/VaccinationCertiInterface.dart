///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:flutter/src/widgets/framework.dart';

class VaccinationCertiInterface extends StatelessWidget {
  const VaccinationCertiInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text("Vaccination Certificate")),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            elevation: 50,
            shadowColor: Colors.black,
            color: Colors.orangeAccent,
            child: SizedBox(
              width: 300,
              height: 450,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent[500],
                      radius: 55,
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.jfif'),
                        radius: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Digital Certificate',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      ' for COVID-19 Vaccination',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'This QR Code only be verified using Vaccine Certificate Verifier App issued by the Government of Malaysia',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    SizedBox(
                      width: 180,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                    title: Text(
                                      "Digital Certificate- QR Code ",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Image(
                                      image: AssetImage(
                                          'assets/images/qrcode.png'),
                                    ));
                              });
                        },

                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Icon(Icons.qr_code),
                              SizedBox(
                                width: 7,
                              ),
                              Text('Digital Certificate'),
                            ],
                          ), //Row
                        ), //Padding
                      ), //RaisedButton
                    ) //SizedBox
                  ],
                ), //Column
              ), //Padding
            ), //SizedBox
          ), //Card
        ), //Center,
      ),

      //Bottom Navigation Bar Starts
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:const Color(0xFFF38B6FF), width: 2),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
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
      ),
    );
    //Bottom Navigation Bar Ends
  }
}
