import 'package:firstapp/contactus.dart';
import 'package:flutter/material.dart';
import 'aboutus.dart';
import 'signup.dart';
import 'login.dart';

class Intermediate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/ambulance.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFbdeff5), Color(0xFF0bf4e4)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        constraints: BoxConstraints(maxWidth: 400),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              'Select an option:',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Signup(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF007BFF),
                                onPrimary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 30,
                                ),
                              ),
                              child: Text('Sign Up'),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF007BFF),
                                onPrimary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 30,
                                ),
                              ),
                              child: Text('Login'),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
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
                    redirectToPage(context, ContactUs());
                  },
                  child: Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    redirectToPage(context, AboutUs());
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

  void redirectToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
