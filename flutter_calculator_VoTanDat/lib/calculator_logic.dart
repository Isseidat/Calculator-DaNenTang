class CalculatorLogic {
  String display = '0';       // số đang nhập
  String equation = '';       // toàn bộ chuỗi phép tính
  double num1 = 0;
  double num2 = 0;
  String operation = '';
  String liveResult = '= 0'; // luôn hiển thị dạng "= ..."
  bool justCalculated = false;

  String _formatDouble(double v) {
    if (v.isNaN) return 'Error';
    if (v == v.toInt()) return v.toInt().toString();
    return v.toString();
  }

  void onButtonPress(String label) {

    // Reset khi vừa tính xong và nhập số mới
    if (justCalculated && RegExp(r'[0-9]').hasMatch(label)) {
      display = label;
      equation = label;
      liveResult = "= $label";
      num1 = 0;
      num2 = 0;
      operation = '';
      justCalculated = false;
      return;
    }

    // Nhập số / decimal
    if (RegExp(r'[0-9]').hasMatch(label) || label == '.') {
      if (label == '.' && display.contains('.')) return;

      if (display == '0' && label != '.') display = label;
      else display += label;

      equation += label;

      // Live result khi đang có phép toán
      if (operation.isNotEmpty) {
        num2 = double.tryParse(display) ?? 0;
        double kq = _compute(num1, num2, operation);
        liveResult = "= ${_formatDouble(kq)}";
      } else {
        liveResult = "= $display";
      }
      return;
    }

    // Nhập phép toán
    if (['+', '-', '×', '/'].contains(label)) {
      if (operation.isNotEmpty && display.isNotEmpty) {
        // Tính kết quả trước khi ghi phép toán mới
        num2 = double.tryParse(display) ?? 0;
        num1 = _compute(num1, num2, operation);
        liveResult = "= ${_formatDouble(num1)}";
      } else {
        num1 = double.tryParse(display) ?? 0;
        liveResult = "= ${_formatDouble(num1)}";
      }

      operation = label;
      equation += " $label "; // thêm khoảng trắng xung quanh phép toán
      display = '';
      justCalculated = false;
      return;
    }

    // ==========================
    //        PHÉP %
    // ==========================
    if (label == '%') {
      double current = double.tryParse(display) ?? 0;

      // Nếu chưa có phép toán → % = chia 100
      if (operation.isEmpty) {
        current = current / 100;
        display = _formatDouble(current);
        equation = display;
        liveResult = "= $display";
        return;
      }

      // Nếu có phép toán: current% của num1
      double base = num1;
      double percentValue = base * (current / 100);

      num2 = percentValue;
      display = _formatDouble(percentValue);

      // Thêm % vào equation nếu chưa có
      if (!equation.trim().endsWith('%')) {
        equation += '%';
      }

      // tính live result luôn
      double kq = _compute(num1, percentValue, operation);
      liveResult = "= ${_formatDouble(kq)}";
      return;
    }

    // Nhấn "="
    if (label == '=') {
      if (operation.isEmpty || display.isEmpty) return;

      num2 = double.tryParse(display) ?? 0;
      num1 = _compute(num1, num2, operation);

      liveResult = "= ${_formatDouble(num1)}";

      operation = '';
      justCalculated = true;
      return;
    }

    // Nhấn "+/-" đổi dấu
    if (label == '+/-') {
      if (display.startsWith('-')) {
        display = display.substring(1);
      } else if (display != '0') {
        display = '-$display';
      }

      // Cập nhật equation
      if (operation.isEmpty) {
        equation = display;
      } else {
        int opIndex = equation.lastIndexOf(operation);
        if (opIndex != -1) {
          equation = equation.substring(0, opIndex + 2) + display; // +2 vì có khoảng trắng
        }
      }

      if (operation.isNotEmpty) {
        num2 = double.tryParse(display) ?? 0;
        double kq = _compute(num1, num2, operation);
        liveResult = "= ${_formatDouble(kq)}";
      } else {
        liveResult = "= $display";
      }
      return;
    }

    // Clear
    if (label == 'C') {
      display = '0';
      liveResult = '= 0';
      equation = '';
      num1 = 0;
      num2 = 0;
      operation = '';
      justCalculated = false;
      return;
    }
  }

  // ==========================
  //  Ưu tiên × ÷ trước + -
  // ==========================
  double _compute(double a, double b, String op) {
    switch (op) {
      case '+': return a + b;
      case '-': return a - b;
      case '×': return a * b;
      case '/': return b == 0 ? double.nan : a / b;
    }
    return 0;
  }
}
