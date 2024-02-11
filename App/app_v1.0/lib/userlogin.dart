import 'package:firstapp/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/hospitalbooking.dart';
import 'contactus.dart';
import 'dbHelper/mongoDB.dart'; // Import your database file

class UserLog extends StatefulWidget {
  @override
  _UserLogState createState() => _UserLogState();
}

class _UserLogState extends State<UserLog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Login'),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Color(0xFFF4F6F7),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 30, 2, 2).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ambulance Login',
                  style: TextStyle(color: Color(0xFF333), fontSize: 24.0),
                ),
                SizedBox(height: 20.0),
                Form(
                  child: Column(
                    children: <Widget>[
                      buildTextField('Username', 'username',
                          controller: _usernameController),
                      buildTextField('Password', 'password',
                          isPassword: true, controller: _passwordController),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    // Validate and authenticate user
                    if (await MongoDataBase.authenticateUser(
                        _usernameController.text, _passwordController.text)) {
                      // Navigate to HospitalBedBooking if authentication is successful
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HospitalBedBooking()),
                      );
                    } else {
                      // Show error message if authentication fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid username or password'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF333),
                    onPrimary: const Color.fromARGB(255, 21, 20, 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color(0xFF192024),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© Copyright @ HealthLink Architects  ',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()),);
                  },
                  child: Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()),);
                  },
                  child: Text(
                    'About Us',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String fieldName,
      {bool isPassword = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: TextFormField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
