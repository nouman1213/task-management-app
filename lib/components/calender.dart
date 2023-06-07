import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  final ScrollController scrollController;
  final int currentDateSelectedIndex;
  final Function(int) onDateSelected;

  Calendar({
    required this.scrollController,
    required this.currentDateSelectedIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    List<String> listOfMonths = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
      height: 80,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 7, // Display only the current 7 days
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              onDateSelected(index);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                  color: currentDateSelectedIndex == index
                      ? Colors.white
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      listOfMonths[
                          DateTime.now().add(Duration(days: index)).month - 1],
                      style: TextStyle(
                        fontSize: 16,
                        color: currentDateSelectedIndex == index
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateTime.now().add(Duration(days: index)).day.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: currentDateSelectedIndex == index
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      listOfDays[
                          DateTime.now().add(Duration(days: index)).weekday -
                              1],
                      style: TextStyle(
                        fontSize: 16,
                        color: currentDateSelectedIndex == index
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
