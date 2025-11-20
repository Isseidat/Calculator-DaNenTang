import 'package:flutter/material.dart';
import 'calculator_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFF2D3142),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic logic = CalculatorLogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // ⭐ Màn hình nhập ở trên — nhỏ lại khi nhấn "="
                    Text(

                      logic.equation.isEmpty ? logic.display : logic.equation,
                      // logic.display,


                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: logic.justCalculated ? 30 : 50,   // ⭐ Thu nhỏ khi ấn =
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    // ⭐ Màn hình kết quả chính — phóng to
                    Text(
                      logic.liveResult,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: logic.justCalculated ? 70 : 50,   // ⭐ Tăng khi ấn =
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),


            // Buttons Area
            Expanded(
              flex: 3,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildButton("C"),
                  buildButton("( )"),
                  buildButton("%"),
                  buildButton("/"),
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("×"),
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-"),
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+"),
                  buildButton("+/-"),
                  buildButton("0"),
                  buildButton("."),
                  buildButton("="),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String label) {
    Color btnColor = Colors.grey[900]!;

    if (label == "C") btnColor = const Color(0xFF963E3E);
    else if (["/", "×", "-", "+"].contains(label)) btnColor = const Color(0xFF394734);
    else if (label == "=") btnColor = const Color(0xFF076544);

    return GestureDetector(
      onTap: () {
        setState(() {
          logic.onButtonPress(label);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: btnColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
