// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class WeeklyCompletionBarChart extends StatelessWidget {
//   final List<int> completedTasks; // List of completed tasks per week

//   const WeeklyCompletionBarChart({super.key, required this.completedTasks});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.5,
//       child: BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.spaceAround,
//           maxY: (completedTasks.reduce((a, b) => a > b ? a : b) * 1.2).ceilToDouble(),
//           barTouchData: BarTouchData(enabled: true),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: true, reservedSize: 30),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, _) {
//                   switch (value.toInt()) {
//                     case 0:
//                       return const Text('Wk 1');
//                     case 1:
//                       return const Text('Wk 2');
//                     case 2:
//                       return const Text('Wk 3');
//                     case 3:
//                       return const Text('Wk 4');
//                     default:
//                       return const Text('');
//                   }
//                 },
//               ),
//             ),
//             topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           ),
//           borderData: FlBorderData(show: false),
//           barGroups: List.generate(completedTasks.length, (index) {
//             return BarChartGroupData(
//               x: index,
//               barRods: [
//                 BarChartRodData(
//                   toY: completedTasks[index].toDouble(),
//                   color: Colors.blueAccent,
//                   width: 22,
//                   borderRadius: BorderRadius.circular(4),
//                 )
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
