import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String address = "null";
  String autocompletePlace = "null";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('location picker'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Google Map Location Picker\nMade By Arvind 😃 with Flutter 🚀",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: MapLocationPicker(
                  apiKey: "YOUR_API_KEY",
                  canPopOnNextButtonTaped: true,
                  showBackButton: false,
                  showNextButton: false,
                  showMoreOptions: false,
                  onLocationSelectionChanged: (GeocodingResult? result) {
                    if (result != null) {
                      setState(() {
                        address = result.formattedAddress ?? "";
                      });
                    }
                  },
                  onNext: (GeocodingResult? result) {},
                  onSuggestionSelected: (PlacesDetailsResponse? result) {
                    if (result != null) {
                      setState(() {
                        autocompletePlace =
                            result.result.formattedAddress ?? "";
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 50,
                child: Center(child: Text('OR')),
              ),
              Center(
                child: ElevatedButton(
                  child: const Text('Pick location'),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MapLocationPicker(
                            apiKey: "YOUR_API_KEY",
                            canPopOnNextButtonTaped: true,
                            onNext: (GeocodingResult? result) {
                              if (result != null) {
                                setState(() {
                                  address = result.formattedAddress ?? "";
                                });
                              }
                            },
                            onSuggestionSelected:
                                (PlacesDetailsResponse? result) {
                              if (result != null) {
                                setState(() {
                                  autocompletePlace =
                                      result.result.formattedAddress ?? "";
                                });
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text("Geocoded Address: $address"),
              ),
              ListTile(
                title: Text("Autocomplete Address: $autocompletePlace"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
