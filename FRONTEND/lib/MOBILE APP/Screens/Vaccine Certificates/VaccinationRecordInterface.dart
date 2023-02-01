///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class VaccinationRecordInterface extends StatelessWidget {
  const VaccinationRecordInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: Text("Vaccination Record")),
      body: Container(
        decoration: BoxDecoration(
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
            shadowColor: Colors.black,
            color: Colors.orangeAccent,
            child: SizedBox(
              width: 300,
              height: 450,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Text(
                      'Vaccination Record',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Textfield 1 Starts
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0))),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              const Icon(Icons.confirmation_num_outlined),
                          hintText: 'Vaccine Batch Number ',
                          labelText: 'Vaccine Batch Number',
                        ),
                      ),
                    ),
                    //Textfield 1 ends
                    SizedBox(
                      height: 10,
                    ),
                    //Textfield 1 Starts
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0))),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.date_range),
                          hintText: 'Vaccine Mfg Date  ',
                          labelText: 'Vaccine Manufacturing Date',
                        ),
                      ),
                    ),
                    //Textfield 1 ends

                    //Textfield 1 ends
                    SizedBox(
                      height: 10,
                    ),
                    //Textfield 1 Starts
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0))),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.warning_amber_rounded),
                          hintText: 'VaccineExpDate ',
                          labelText: 'Vaccine Expiry Date',
                        ),
                      ),
                    ),
                    //Textfield 1 ends

                    //Textfield 1 ends
                    SizedBox(
                      height: 10,
                    ),
                    //Textfield 1 Starts
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0))),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.verified),
                          hintText: 'VaccineBrand  ',
                          labelText: 'Vaccine Brand ',
                        ),
                      ),
                    ),
                    //Textfield 1 ends
                  ],
                ),
              ),
            ),
          ),
        ),
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
      ),
    );
    //Bottom Navigation Bar Ends
  }
}
