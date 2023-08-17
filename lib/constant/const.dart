import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void showAlert({String? title, String? message}) {
  Get.snackbar(
    title!,
    message!,
    duration: Duration(seconds: 3),
    backgroundColor: Colors.white,
    colorText: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
    mainButton: TextButton(
      onPressed: () {
        // Perform an action when the SnackBar action button is pressed.
        Get.back();
      },
      child: Text(
        'Close',
        style: TextStyle(color: Colors.blue.shade900),
      ),
    ),
  );
}

enum TaskStatus {
  todo(Icons.assignment, Colors.pink),
  progress(Icons.incomplete_circle, Colors.amber),
  done(Icons.done, Colors.green);
  // favorite(Icons.favorite, Colors.red);

  final IconData icon;
  final Color color;
  const TaskStatus(this.icon, this.color);
}

TextStyle kTextStyleGrey(context, double size) {
  return GoogleFonts.arimaMadurai(
    textStyle:
        TextStyle(fontSize: size, color: Theme.of(context).colorScheme.outline),
  );
}

TextStyle kTextStyleWhite(context, double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
        fontSize: size, color: Theme.of(context).colorScheme.onPrimary),
  );
}

TextStyle kTextStyleBlack(context, double size) {
  return GoogleFonts.arimaMadurai(
    textStyle:
        TextStyle(fontSize: size, color: Theme.of(context).colorScheme.primary),
  );
}

TextStyle kTextStyleBoldGrey(context, double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
      fontSize: size,
      color: Theme.of(context).colorScheme.outline,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle kTextStyleBoldBlack(context, double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
      fontSize: size,
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle kTextStyleBoldAmber(double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
      fontSize: size,
      color: Colors.amber,
      fontWeight: FontWeight.bold,
    ),
  );
}

Color mycolor = Color.fromARGB(255, 22, 34, 70);

TextStyle kTextStyleBoldWhite(context, double size) {
  return GoogleFonts.arimaMadurai(
    textStyle: TextStyle(
      fontSize: size,
      color: Theme.of(context).colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle kTextStyleBoldBlack2(context, double size) {
  return GoogleFonts.orbitron(
    textStyle: TextStyle(
      fontSize: size,
      color: Theme.of(context).colorScheme.outline,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget kVerticalSpace(double height) => SizedBox(height: height);
Widget kHorizontleSpace(double width) => SizedBox(width: width);

const List<Color> colors = [
  Colors.pink,
  Colors.purple,
  Colors.amber,
  Colors.orange,
  Colors.teal,
  Colors.green,
  Colors.blue,
  Colors.blueGrey,
];

String showGreeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good Afternoon';
  } else if (hour < 20 && hour >= 17) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

String formattingTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final date = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
  final format = DateFormat.jm();
  return format.format(date);
}
