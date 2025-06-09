import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:jam/view/widgets/calendar_widget.dart';

void main() {
  testWidgets('CalendarWidget renders correctly', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: CalendarWidget())),
    );

    // Verify the calendar is displayed
    expect(find.byType(TableCalendar), findsOneWidget);

    // Verify the container styling
    final container = tester.widget<Container>(find.byType(Container).first);
    expect(container.decoration, isA<BoxDecoration>());
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(16));
    expect(decoration.boxShadow, isNotEmpty);
  });

  testWidgets('CalendarWidget displays current month', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: CalendarWidget())),
    );

    final now = DateTime.now();
    final monthYear = '${_getMonthName(now.month)} ${now.year}';
    expect(find.text(monthYear), findsOneWidget);
  });

  testWidgets('CalendarWidget allows day selection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: CalendarWidget())),
    );

    // Find a day cell that's not today (to avoid flaky tests)
    final today = DateTime.now();
    final testDay =
        today.day == 15
            ? today.add(Duration(days: 1))
            : DateTime(today.year, today.month, 15);

    // Tap on the 15th day of the month
    final dayFinder = find.text('15');
    expect(dayFinder, findsOneWidget);

    await tester.tap(dayFinder);
    await tester.pump();

    // Verify the day was selected by checking the selected decoration
    // This is a bit tricky with TableCalendar as it doesn't expose selection state directly
    // Instead, we can verify the onDaySelected callback was triggered
    // by checking if the widget rebuilt (which it should based on your code)

    // Alternative: Verify the selected day has the border style
    // This is more of an integration test than a pure widget test
    final selectedDayFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).border != null,
    );
    expect(selectedDayFinder, findsOneWidget);
  });

  testWidgets('CalendarWidget allows month navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: CalendarWidget())),
    );

    final initialMonth = DateTime.now();
    final initialMonthText =
        '${_getMonthName(initialMonth.month)} ${initialMonth.year}';
    expect(find.text(initialMonthText), findsOneWidget);

    // Tap the next month button
    final nextButton = find.byIcon(Icons.chevron_right);
    await tester.tap(nextButton);
    await tester.pumpAndSettle(); // Wait for animations

    DateTime nextMonth;
    if (initialMonth.month == 12) {
      nextMonth = DateTime(initialMonth.year + 1, 1, 1);
    } else {
      nextMonth = DateTime(initialMonth.year, initialMonth.month + 1, 1);
    }

    final nextMonthText = '${_getMonthName(nextMonth.month)} ${nextMonth.year}';
    expect(find.textContaining(RegExp(nextMonthText)), findsOneWidget);

    // Tap the previous month button to go back
    final prevButton = find.byIcon(Icons.chevron_left);
    await tester.tap(prevButton);
    await tester.pumpAndSettle();

    expect(find.textContaining(RegExp(initialMonthText)), findsOneWidget);
  });
}

String _getMonthName(int month) {
  return [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ][month - 1];
}
