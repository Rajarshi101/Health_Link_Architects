import 'package:firstapp/getwellsoon.dart';
import 'package:firstapp/hospital_bed_management.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'aboutus.dart';
import 'package:firstapp/contactus.dart';
import 'package:firstapp/dbHelper/mongoDB.dart';
// import 'package:location/location.dart' as location;


class HospitalBedBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Hospital Bed Booking'),
          leading: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          actions: [
            // Add your new button here
            IconButton(
              icon: Icon(Icons.medical_information_rounded),
              onPressed: () {
                // Handle the press event for the new button
                // For example, you can navigate to a new screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalBed()),
                );
              },
            ),
          ],
        ),
        body: HospitalBedBookingForm(),
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
}

class HospitalBedBookingForm extends StatefulWidget {
  @override
  _HospitalBedBookingFormState createState() => _HospitalBedBookingFormState();
}

class _HospitalBedBookingFormState extends State<HospitalBedBookingForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // Map<String, double> location = {};
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Hospital Bed Booking',
            style: TextStyle(fontSize: 24.0),
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Enter Name:'),
                ),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(labelText: 'Enter Reason:'),
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Enter Phone No:'),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Enter Address:'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await getLocation();
                    Position position = await _getGeoLocationPosition();
                    Map<String, double> location = {
                      'latitude': position.latitude,
                      'longitude': position.longitude,
                    };
                    submitForm(location);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> getLocation() async {
  //   try {
  //     locationData = await location.getLocation();
  //   } catch (e) {
  //     print('Error getting location: $e');
  //   }
  // }

  void submitForm(Map<String, double> location) {
    String name = nameController.text;
    String reason = reasonController.text;
    String phone = phoneController.text;
    String address = addressController.text;
    double Lat = location['latitude'] ?? 0.0;
    double Lon = location['longitude'] ?? 0.0;
    print(location);
    // Check if locationData is not null before accessing latitude and longitude
    // if (locationData != null) {
    //   double latitude = locationData.latitude ?? 0.0;
    //   double longitude = locationData.longitude ?? 0.0;

      // Add your logic to handle form submission
      // You can use the form data (name, reason, phone, address, latitude, longitude) as needed

      // Example: Displaying an alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Details'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: $name'),
                Text('Reason: $reason'),
                Text('Phone: $phone'),
                Text('Address: $address'),
                Text('Latitude: $Lat'),
                Text('Longitude: $Lon'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  MongoDataBase.userInsert(
                      name, reason, phone, address,Lat,Lon);
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => GetWellSoon()),);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    // } else {
    //   print('Location data is not available.');
    // }
    void redirectToPage(BuildContext context, Widget page) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }
}
