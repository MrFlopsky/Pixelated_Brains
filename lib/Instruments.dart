import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InstrumentSelector(),
    );
  }
}

class InstrumentSelector extends StatefulWidget {
  @override
  _InstrumentSelectorState createState() => _InstrumentSelectorState();
}

class _InstrumentSelectorState extends State<InstrumentSelector> {
  final List<String> instruments = [
    "Saxophone",
    "Piano", 
    "Bass",
    "Trumpet",
    "Flute",
    "Keyboard",
    "Guitar",
    "Percussion",
  ];
  final Set<String> selectedInstruments = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D1838),
      appBar: AppBar(
        title: Text("Select Instruments"),
        backgroundColor: Color(0xFF4A1942),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xFF4A1942),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Text(
              "Selected: ${selectedInstruments.length}/${instruments.length}",
              style: TextStyle(
                color: Color(0xFFFFE4E1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: instruments.length,
              itemBuilder: (context, index) {
                final instrument = instruments[index];
                final isSelected = selectedInstruments.contains(instrument);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedInstruments.remove(instrument);
                      } else {  
                        selectedInstruments.add(instrument);
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Color(0xFF4A1942).withOpacity(0.8)
                          : Color(0xFF3B1E40).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? Color(0xFFE6E6FA)
                            : Color(0xFFE6E6FA).withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          instrument,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      Color(0xFFFF1B6B),
                                      Color(0xFFE6E6FA),
                                    ],
                                  )
                                : null,
                            color: isSelected ? null : Color(0xFF2D1838),
                            borderRadius: BorderRadius.circular(12.5),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Color(0xFFFF1B6B).withOpacity(0.8),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    )
                                  ]
                                : [],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}