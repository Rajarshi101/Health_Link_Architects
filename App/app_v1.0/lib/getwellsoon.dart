import 'package:flutter/material.dart';



class GetWellSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GetWellSoonScreen(),
      ),
    );
  }
}

class GetWellSoonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.dropbox.com/scl/fi/3sj9eajlddcz5hkwetj32/getwellsoon.jpeg?rlkey=veyw9ex9221bxul6ux1f64p2i&dl=1'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'We Hope You Get Well Soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 20),
                ButtonContainer(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle Usermap button click
                    // You can navigate to another screen or perform an action
                  },
                  child: Text(
                    'Usermap',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        Footer(),
      ],
    );
  }
}

class ButtonContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            confirmAction(context, 'cancel');
          },
          child: Text('Cancel Booking'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            confirmAction(context, 'rebooking');
          },
          child: Text('ReBooking'),
        ),
      ],
    );
  }

  void confirmAction(BuildContext context, String action) async {
    bool confirmation = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text(
          action == 'cancel'
              ? 'Are you sure you want to cancel the booking?'
              : 'Are you sure to redirect?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
        ],
      ),
    );

    if (confirmation != null && confirmation) {
      // Handle the confirmed action
      if (action == 'cancel') {
        // Implement cancel booking logic
      } else if (action == 'rebooking') {
        // Implement rebooking logic
      }
    }
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '© Copyright @ Get Well Soon',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              // Handle Contact Us
            },
            child: Text(
              'Contact Us',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              // Handle About Us
            },
            child: Text(
              'About Us',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ],
      ),
    );
  }
}
