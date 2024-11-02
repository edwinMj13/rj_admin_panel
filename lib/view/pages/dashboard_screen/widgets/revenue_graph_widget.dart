import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_rj_admin_panel/data/models/revenue_model.dart';
import 'package:project_rj_admin_panel/data/models/summary_data_model.dart';
import 'package:project_rj_admin_panel/view/providers/graph_summary_provider.dart';
import 'package:provider/provider.dart';

import '../../../../services/graph_summary_services.dart';


class RevenueGraphWidget extends StatefulWidget {
  RevenueGraphWidget({super.key});

  @override
  State<RevenueGraphWidget> createState() => _RevenueGraphWidgetState();
}

class _RevenueGraphWidgetState extends State<RevenueGraphWidget> {
  final graphProvider = GraphSummaryServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    graphProvider.getGraphData();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child:
            ValueListenableBuilder<RevenueModel>(
                valueListenable: GraphSummaryServices.revenueNotifier,
                builder: (context,value,_) {
                  print("Jan ${double.parse(value.totalJan)}");
                  return LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              /*  print("sideTitles Value $value \n"
                              "bottomTitles max $value ${meta.max}\n"
                              "bottomTitles min $value ${meta.min}\n"
                              "bottomTitles appliedInterval $value ${meta.appliedInterval}\n"
                              "bottomTitles axisPosition $value ${meta.axisPosition}\n"
                              "bottomTitles axisSide $value ${meta.axisSide}\n"
                              "bottomTitles formattedValue $value ${meta.formattedValue}\n"
                              "bottomTitles parentAxisSize $value ${meta.parentAxisSize}\n"
                              "bottomTitles sideTitles $value ${meta.sideTitles}\n");*/
                              switch (value.toInt()) {
                                case 1:
                                  return Text('JAN');
                                case 2:
                                  return Text('FEB');
                                case 3:
                                  return Text('MAR');
                                case 4:
                                  return Text('APR');
                                case 5:
                                  return Text('MAY');
                                case 6:
                                  return Text('JUN');
                                case 7:
                                  return Text('JUL');
                                case 8:
                                  return Text('AUG');
                                case 9:
                                  return Text('SEP');
                                case 10:
                                  return Text('OCT');
                                case  11:
                                  return Text('NOV');
                                case  12:
                                  return Text('DEC');
                                default:
                                  return Text('');
                              }
                            },
                          ),
                        ),
                      ),
                      minX: 1,
                      maxX: 12,
                      minY: 10,
                      maxY: 20,
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots:  [
                            FlSpot(1, double.parse(value.totalJan)),
                            FlSpot(2, double.parse(value.totalFeb)),
                            FlSpot(3, double.parse(value.totalMar)),
                            FlSpot(4, double.parse(value.totalApr)),
                            FlSpot(5, double.parse(value.totalMay)),
                            FlSpot(6, double.parse(value.totalJun)),
                            FlSpot(7, double.parse(value.totalJul)),
                            FlSpot(8, double.parse(value.totalAug)),
                            FlSpot(9, double.parse(value.totalSep)),
                            FlSpot(10, double.parse(value.totalOct)),
                            FlSpot(11, double.parse(value.totalNov)),
                            FlSpot(12, double.parse(value.totalDec)),
                          ],
                          belowBarData: BarAreaData(show: false),
                          color: Colors.blue,
                          dotData: FlDotData(show: true),
                        ),
                      ],
                    ),
                  );
                }
            )
        ),
      ],
    );
  }
}