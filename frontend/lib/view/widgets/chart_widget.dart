import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jam/view/widgets/colors.dart';

int bar_1 = 7;
int bar_2 = 4;
int bar_3 = 14;
int bar_4 = 2;
int bar_5 = 1;

class WeeklyCompletionBarChart extends StatelessWidget {
  final List<int> completedTasks;

  const WeeklyCompletionBarChart({super.key, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    RotatedBox(
                      quarterTurns: -1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Task Left',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY:
                              (completedTasks.reduce((a, b) => a > b ? a : b) *
                                      1.2)
                                  .ceilToDouble(),
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, _) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return Text(
                                        '1',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      );
                                    case 1:
                                      return Text(
                                        '2',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      );
                                    case 2:
                                      return Text(
                                        '3',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      );
                                    case 3:
                                      return Text(
                                        '4',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      );
                                    case 4:
                                      return Text(
                                        '5',
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                        ),
                                      );
                                    default:
                                      return const Text('');
                                  }
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          // Add these lines for axis borders
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[400]!,
                                width: 1,
                              ),
                              left: BorderSide(
                                color: Colors.grey[400]!,
                                width: 1,
                              ),
                            ),
                          ),
                          // Add these lines for grid lines
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 5,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.grey[200]!,
                                strokeWidth: 1,
                              );
                            },
                          ),
                          barGroups: List.generate(completedTasks.length, (
                            index,
                          ) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: completedTasks[index].toDouble(),
                                  color: primaryColor,
                                  width: 30,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Week',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
