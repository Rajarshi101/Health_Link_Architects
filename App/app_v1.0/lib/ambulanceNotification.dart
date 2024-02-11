import 'package:firstapp/dbHelper/constant.dart';
import 'package:firstapp/dbHelper/mongoDB.dart';
import 'package:flutter/material.dart';
import 'contactus.dart';

class AmbulanaceNotification extends StatefulWidget {
  @override
  _AmbulanaceNotificationState createState() => _AmbulanaceNotificationState();
}

class _AmbulanaceNotificationState extends State<AmbulanaceNotification> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> pendingData = [];
  List<Map<String, dynamic>> acceptedData = [];

  @override
  void initState() {
    super.initState();
    fetchPendingData();
    fetchAcceptedData();
  }

  Future<void> fetchPendingData() async {
    try {
      List<Map<String, dynamic>> data =
          await MongoDataBase.getPendingAmbulanceData(PENDING_AMBULANCE_DATA);
      setState(() {
        pendingData = data;
        print('Pending data length: ${pendingData.length}');
      });
    } catch (e) {
      print('Error fetching pending data: $e');
    }
  }

  Future<void> fetchAcceptedData() async {
    try {
      List<Map<String, dynamic>> data =
          await MongoDataBase.getAcceptedAmbulanceData(ACCEPTED_AMBULANCE_DATA);
      setState(() {
        acceptedData = data;
        print('Pending data length: ${acceptedData.length}');
      });
    } catch (e) {
      print('Error fetching pending data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pending Requests',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                buildDataTable(pendingData),
                SizedBox(height: 20.0),
                Text(
                  'Accepted Requests',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                // You can use a similar approach to fetch accepted data if needed
                buildDataTable(acceptedData),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle location update
                  },
                  child: Text('Update Location'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUs()),
            );
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification Centre',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone),
              label: 'Contact Us',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataTable(List<Map<String, dynamic>> data) {
    return DataTable(
      columns: [
        DataColumn(label: Text('S.No')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Reason')),
        DataColumn(label: Text('Phone')),
        DataColumn(label: Text('Address')),
        DataColumn(label: Text('Actions')),
      ],
      rows: data.asMap().entries.map((entry) {
        int index = entry.key + 1; // Adding 1 to make it 1-based index
        Map<String, dynamic> row = entry.value;
        return DataRow(
          cells: [  
            DataCell(Text(index.toString())),
            DataCell(Text(row['name']?.toString() ?? '')),
            DataCell(Text(row['reason']?.toString() ?? '')),
            DataCell(Text(row['phone']?.toString() ?? '')),
            DataCell(Text(row['address']?.toString() ?? '')),
            DataCell(
              ElevatedButton(
                onPressed: () {
                  // Handle actions
                },
                child: Text('Action'),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  
}
