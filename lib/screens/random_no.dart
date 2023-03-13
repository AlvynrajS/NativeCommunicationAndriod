import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RandomNumber extends StatefulWidget {
  const RandomNumber({Key? key}) : super(key: key);

  @override
  State<RandomNumber> createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  int random = 1;
  int batteryLevel = 0;
  String mobileModel = "unknown model Name";
  String version = "unknown Version";
  String data = "unknown Data";
  String simCard = "Unknown Sim Details";
  String simCardNos = "0";
  String operatorName = "Unknown operator";
  String simOperator = "Unknown SimOperator";
  String countryCode = "Unknown countryCode";
  String simSerialNo = "unknown SIM Serial No";
  late String lastLocation = "Unknown last Location";
  late String latitude = "Unknown latitude Location";
  late String longitude = "Unknown longitude Location";
  String versionCode = "unknown version code";
  late String currentLocation = "Unknown Current Location";
  late String cLatitude = "Unknown latitude Location";
  late String cLongitude = "Unknown longitude Location";


  var platformChannel = const MethodChannel("example.com");

  Future<void> getRandomNumber() async {
    int no;
    try {
      no = await platformChannel.invokeMethod("getRandomNumber");
    } on PlatformException catch (e) {
      no = 0;
    }
    setState(() {
      random = no;
    });
  }

  Future<void> getBatteryLevel() async {
    int percentage;
    try {
      percentage = await platformChannel.invokeMethod("getBatteryLevel");
    } on PlatformException catch (e) {
      percentage = 0;
    }
    setState(() {
      batteryLevel = percentage;
    });
  }

  Future<void> getMobileModel() async {
    String model;
    String versionName;
    String dataString;
    String simString;
    String version2Name;
    String buildVersionCode;
    try {
      var result = await platformChannel.invokeMethod("getMobileModel");
      model = result[0];
      versionName = result[1];
      version2Name = result[3];
      simString = result[2];
      buildVersionCode = result[4];
    } on PlatformException catch (e) {
      model = "unable to get model name";
      versionName = "Unable to get Version";
      version2Name = "unable to get  version 2";
      simString = "Sim String not available";
      buildVersionCode = "Unable to get build Version code";
    }
    setState(() {
      mobileModel = model;
      version = versionName;
      data = version2Name;
      simCard = simString;
      versionCode = buildVersionCode;
    });
  }

  Future<void> getSimCardDetails() async {
    String operator;
    String sOperator;
    String cCode;
    try {
      var noOfSimCards =
          await platformChannel.invokeMethod("getSimCardDetails");
      operator = noOfSimCards[0];
      sOperator = noOfSimCards[1];
      cCode = noOfSimCards[2];
    } on PlatformException catch (e) {
      operator = "No data available";
      sOperator = "No data available";
      cCode = "No data available";
    }
    setState(() {
      operatorName = operator;
      simOperator = sOperator;
      countryCode = cCode;
    });
  }

  Future<void> getLastLocation() async {
    try {
      await platformChannel.invokeMethod("getLastLocation").then((value) {
        setState(() {
          lastLocation = value[0];
          latitude = value[1];
          longitude = value[2];
        });
      });
    } on PlatformException catch (e) {
      lastLocation = "Unable to get Last Location";
      latitude =  "Unable to get Latitude Location";
      longitude =  "Unable to get Longitude Location";
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      await platformChannel.invokeMethod("getCurrentLocation").then((value) {
        setState(() {
          lastLocation = value[0];
          latitude = value[1];
          longitude = value[2];
        });
      });
    } on PlatformException catch (e) {
      lastLocation = "Unable to get Last Location";
      latitude =  "Unable to get Latitude Location";
      longitude =  "Unable to get Longitude Location";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Random No"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // random no
              const SizedBox(
                height: 10,
              ),
              const Text("Random no"),
              Text("$random"),
              ElevatedButton(
                  onPressed: () {
                    getRandomNumber();
                  },
                  child: Text("Random No getting button")),
              // battery level
              const SizedBox(
                height: 10,
              ),
              const Text("Mobile battery Level"),
              Text("$batteryLevel %"),
              ElevatedButton(
                  onPressed: () {
                    getBatteryLevel();
                  },
                  child: const Text("get battery Level")),
              // mobile model
              const SizedBox(height: 10),
              const Text("Mobile Model"),
              Text("Mobile Model : $mobileModel "),
              Text("version : $version"),
              Text("data : $data"),
              Text("simCard : $simCard"),
              Text("simCardNos : $simCard"),
              Text("version Code : $versionCode"),
              ElevatedButton(
                  onPressed: () {
                    getMobileModel();
                  },
                  child: const Text("get Mobile Model")),
              // Sim card details
              const SizedBox(height: 10),
              const Text("Sim Card Details"),
              Text("operatorName : $operatorName"),
              Text("simOperator  : $simOperator"),
              Text("countryCode  : $countryCode"),
              // Text("simSerialNo  : $simSerialNo"),
              ElevatedButton(
                  onPressed: () {
                    getSimCardDetails();
                  },
                  child: const Text("get Sim card Details")),
              // last location details
              const SizedBox(height: 10),
              const Text("Last Location Details"),
              Text("lastLocation : $lastLocation"),
               Text("Latitude  : $latitude"),
               Text("longitude  : $longitude"),
              // Text("simSerialNo  : $simSerialNo"),
              ElevatedButton(
                  onPressed: () async {
                    await getLastLocation();
                  },
                  child: const Text("get Last Location Details")),
              // Current location details
              const SizedBox(height: 10),
              const Text("Current  Location Details"),
              Text("currentLocation : $currentLocation"),
               Text("Latitude  : $cLatitude"),
               Text("longitude  : $cLongitude"),
              // Text("simSerialNo  : $simSerialNo"),
              ElevatedButton(
                  onPressed: () async {
                    await getCurrentLocation();
                  },
                  child: const Text("get Current Location Details")),
            ],
          ),
        ),
      ),
    );
  }
}
