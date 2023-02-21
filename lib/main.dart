import 'package:flutter/material.dart';

//This function triggers the build process
void main() => runApp(const MyApp());

// StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double? bmi;
  double? neededWeight;
  int? res;

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;
    if (result > 25) {
      res = 2;
      neededWeight = weight - (22.5 * heightSquare);
    } else if (result < 18) {
      res = 0;
      neededWeight = (weight - (22.5 * heightSquare)) * -1;
    } else if (result >= 18 && result <= 25) res = 1;
    bmi = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Calculate your BMI"),
            centerTitle: true,
          ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 20),
                    Flexible(
                      child: TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your height (cm)',
                        ),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: weightController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your weight (kg)',
                        ),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          fixedSize: Size(150, 50)),
                      onPressed: calculateBMI,
                      child: Text('Calculate'),
                    ),
                    SizedBox(height: 30),
                    Text(
                      bmi == null
                          ? "Enter your information!"
                          : "Results BMI: ${bmi?.toStringAsFixed(2)}" +
                              " " +
                              (res == 2
                                  ? "Overweight"
                                  : res == 1
                                      ? "Normal"
                                      : "Underweight"),
                      style: TextStyle(
                        color: bmi == null || res == 2
                            ? Colors.redAccent
                            : res == 1
                                ? Colors.green
                                : Colors.yellow[700],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      bmi != null && (res == 2 || res == 0)
                          ? res == 2
                              ? "You need to lose ${neededWeight?.toStringAsFixed(2)} kg so that you BMI is 22.5"
                              : "You need to gain ${neededWeight?.toStringAsFixed(2)} kg so that you BMI is 22.5"
                          : "",
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ])),
        ));
  }
}
