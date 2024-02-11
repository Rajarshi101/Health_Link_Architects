import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';

class MongoDataBase {
  static late Db db;
  static late DbCollection userCollection;
  static late DbCollection ambulanceCollection;
  static late DbCollection hospitalCollection;
  static Future<void> connect() async {
    try {
      db = await Db.create(MONGO_CONN_URL);
      await db.open();

      print('Connected to MongoDB');
    } catch (e) {
      print('Error connecting to MongoDB: $e');
      rethrow; // Rethrow the exception to propagate the error
    }
  }

  static Future<void> insertUser(Map<String, dynamic> userData) async {
    userCollection = db.collection(USER_COLLECTION);
    try {
      // Ensure the connection is established before attempting to insert
      if (db == null || !db.isConnected) {
        await connect();
      }

      await userCollection.insertOne(userData);
      print('User data inserted successfully.');
    } catch (e) {
      print('Error inserting user data: $e');
    }
  }

  static Future<void> insertAmbulance(
      Map<String, dynamic> ambulanceData) async {
    ambulanceCollection = db.collection(AMBULANCE_COLLECTION);
    try {
      // Ensure the connection is established before attempting to insert
      if (db == null || !db.isConnected) {
        await connect();
      }

      // Ensure ambulanceCollection is initialized
      if (ambulanceCollection == null) {
        throw StateError('ambulanceCollection is not initialized');
      }

      await ambulanceCollection.insertOne(ambulanceData);
      print('Ambulance data inserted successfully.');
    } catch (e) {
      print('Error inserting ambulance data: $e');
    }
  }

  static Future<void> insertHospital(Map<String, dynamic> hospitalData) async {
    hospitalCollection = db.collection(HOSPITAL_COLLECTION);
    try {
      if (db == null || !db.isConnected) {
        await connect();
      }
      if (hospitalCollection == null) {
        throw StateError("hospitalCollection is not initialized");
      }
      await hospitalCollection.insertOne(hospitalData);
      print('Hospital Data inserted successfully');
    } catch (e) {
      print('Error inserting hospital data: $e');
    }
  }

  static Future<bool> authenticateUser(String username, String password) async {
    userCollection = db.collection(USER_COLLECTION);
    await MongoDataBase.connect();
    final result = await MongoDataBase.userCollection.findOne({
      'username': username,
      'password': password,
    });

    return result != null;
  }

  static Future<bool> authenticateAmbulance(
      String username, String password) async {
    ambulanceCollection = db.collection(AMBULANCE_COLLECTION);
    await MongoDataBase.connect();
    final result = await MongoDataBase.ambulanceCollection.findOne({
      'username': username,
      'password': password,
    });
    return result != null;
  }

  static Future<bool> authenticateHospital(
      String username, String password) async {
    hospitalCollection = db.collection(HOSPITAL_COLLECTION);
    await MongoDataBase.connect();
    final result = await MongoDataBase.hospitalCollection.findOne({
      'username': username,
      'password': password,
    });
    return result != null;
  }

  static Future<void> userInsert(
      String name, String reason, String phone, String address,double latitude,double longitude) async {
    var ambulancePendingCollection = db.collection(PENDING_AMBULANCE_DATA);
    try {
      // Ensure the connection is established before attempting to insert
      if (db == null || !db.isConnected) {
        await connect();
      }

      // Ensure ambulanceCollection is initialized
      if (ambulancePendingCollection == null) {
        throw StateError('ambulanceCollection is not initialized');
      }

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String formattedTime = DateFormat('HH:mm').format(now);

      Map<String, dynamic> ambulanceData = {
        'name': name,
        'reason': reason,
        'phone': phone,
        'address': address,
        'date': formattedDate,
        'time': formattedTime,
        'latitude': latitude,
        'longitude': longitude,
      };

      await ambulancePendingCollection.insertOne(ambulanceData);
      print('Ambulance data inserted successfully.');
    } catch (e) {
      print('Error inserting ambulance data: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getPendingAmbulanceData(
      String collectionName) async {
    DbCollection pendingDataCollections = db.collection(collectionName);

    try {
      if (db == null || !db.isConnected) {
        await connect();
      }

      if (pendingDataCollections == null) {
        throw StateError('$collectionName collection is not initialized');
      }

      final List<Map<String, dynamic>> result =
          await pendingDataCollections.find().toList();

      print('Fetched data: $result'); // Add this line to print the fetched data

      return result;
    } catch (e) {
      print('Error fetching data from $collectionName collection: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getAcceptedAmbulanceData(
      String collectionName) async {
    DbCollection acceptedDataCollection = db.collection(collectionName);

    try {
      if (db == null || !db.isConnected) {
        await connect();
      }

      if (acceptedDataCollection == null) {
        throw StateError('$collectionName collection is not initialized');
      }

      final List<Map<String, dynamic>> result =
          await acceptedDataCollection.find().toList();

      print('Fetched data: $result'); // Add this line to print the fetched data

      return result;
    } catch (e) {
      print('Error fetching data from $collectionName collection: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getPendingHospital(String collectionName) async {
    DbCollection pendingDataCollections = db.collection(collectionName);

    try {
      if (db == null || !db.isConnected) {
        await connect();
      }

      if (pendingDataCollections == null) {
        throw StateError('$collectionName collection is not initialized');
      }

      final List<Map<String, dynamic>> result =
          await pendingDataCollections.find().toList();

      print('Fetched data: $result'); // Add this line to print the fetched data

      return result;
    } catch (e) {
      print('Error fetching data from $collectionName collection: $e');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getAceptedHospital(String collectionName) async {
    DbCollection acceptedDataCollection = db.collection(collectionName);
    try {
      if (db == null || !db.isConnected) {
        await connect();
      }

      if (acceptedDataCollection == null) {
        throw StateError('$collectionName collection is not initialized');
      }

      final List<Map<String, dynamic>> result =
          await acceptedDataCollection.find().toList();

      print('Fetched data: $result'); // Add this line to print the fetched data

      return result;
    } catch (e) {
      print('Error fetching data from $collectionName collection: $e');
      return [];
    }
  }
}
