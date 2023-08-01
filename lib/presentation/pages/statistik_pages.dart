import 'package:digifest/data/model/expenditure_table.dart';
import 'package:digifest/data/model/income_table.dart';
import 'package:digifest/presentation/provider/data_provider.dart';
import 'package:digifest/presentation/widget/card_statistik_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dart:math' as math;

import '../../data/model/allowance_table.dart';

class StatistikPages extends StatefulWidget {
  const StatistikPages({Key? key}) : super(key: key);

  @override
  State<StatistikPages> createState() => _StatistikPagesState();
}

class _StatistikPagesState extends State<StatistikPages> {
  DateTime now = DateTime.now();
  List<String> categoriesLabel = [];
  List<ChartData> datasourcePieChart = [];

  @override
  Widget build(BuildContext context) {
    datasourcePieChart = generateDataByMonth(context, now.month, now.year);

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.deepPurple,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
        Column(
          children: [
            Flexible(
              flex: 0,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          now = DateTime(now.year, now.month - 1);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_left,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMM().format(now).toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          now = DateTime(now.year, now.month + 1);
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            categoriesLabel.isEmpty && datasourcePieChart[0].y == 0
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(10),
                    child: const Text('Data Tidak Ditemukan'),
                  )
                : Flexible(
                    flex: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      child: SfCircularChart(
                        legend: const Legend(isVisible: true),
                        series: [
                          PieSeries(
                              dataSource: datasourcePieChart,
                              pointColorMapper: (data, _) => data.color,
                              xValueMapper: (data, _) => data.x,
                              yValueMapper: (data, _) => data.y,
                              explode: true
                              // dataLabelSettings: const DataLabelSettings(
                              //   // color: Colors.black38,
                              //   isVisible: true,
                              // ),
                              // // enableTooltip: true,
                              // dataLabelMapper: (data, _) => data.x,
                              )
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categoriesLabel.isEmpty &&
                        categoriesLabel.isEmpty &&
                        datasourcePieChart[0].y == 0
                    ? 0
                    : categoriesLabel.length + 1,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return CardStatistikData(
                      title: 'Pemasukan',
                      transactionCount: () {
                        List<IncomeTable> data = List.from(
                            context.read<DataProvider>().incomeTableDataList);
                        data.removeWhere((element) => !DateTime(
                                element.tanggal!.year, element.tanggal!.month)
                            .isAtSameMomentAs(DateTime(now.year, now.month)));
                        return data.length;
                      },
                      nominal: () {
                        List<IncomeTable> data = List.from(
                            context.read<DataProvider>().incomeTableDataList);
                        data.removeWhere((element) => !DateTime(
                                element.tanggal!.year, element.tanggal!.month)
                            .isAtSameMomentAs(DateTime(now.year, now.month)));

                        int result = 0;

                        for (int i = 0; i < data.length; i++) {
                          result += data[i].jumlah!;
                        }

                        return result;
                      },
                    );
                  } else {
                    return CardStatistikData(
                      title: categoriesLabel[index - 1],
                      transactionCount: () {
                        List<AllowanceTable> data = List.from(context
                                .read<DataProvider>()
                                .allowanceTableData[categoriesLabel[index - 1]]
                            as List<AllowanceTable>);

                        data.removeWhere((element) => !DateTime(
                                element.tanggal!.year, element.tanggal!.month)
                            .isAtSameMomentAs(DateTime(now.year, now.month)));
                        return data.length;
                      },
                      nominal: () {
                        List<AllowanceTable> data = List.from(context
                                .read<DataProvider>()
                                .allowanceTableData[categoriesLabel[index - 1]]
                            as List<AllowanceTable>);

                        data.removeWhere((element) => !DateTime(
                                element.tanggal!.year, element.tanggal!.month)
                            .isAtSameMomentAs(DateTime(now.year, now.month)));

                        int result = 0;

                        for (int i = 0; i < data.length; i++) {
                          result += data[i].jumlah!;
                        }

                        return result;
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<ChartData> generateDataByMonth(
      BuildContext context, int month, int year) {
    List<ChartData> buffer = [];
    DataProvider dataProv = context.read<DataProvider>();

    List<IncomeTable> data = List.from(dataProv.incomeTableDataList);
    data.removeWhere((element) =>
        !DateTime(element.tanggal!.year, element.tanggal!.month)
            .isAtSameMomentAs(DateTime(now.year, now.month)));

    int result = 0;

    for (int i = 0; i < data.length; i++) {
      result += data[i].jumlah!;
    }

    buffer.add(
      ChartData(
        'Pemasukan',
        result.toDouble(),
        Colors.lightGreenAccent,
      ),
    );

    categoriesLabel.clear();

    for (int i = 0; i < dataProv.allowanceCategories.length; i++) {
      List<AllowanceTable> filter = List.from(
          dataProv.allowanceTableData[dataProv.allowanceCategories[i]]
              as List<AllowanceTable>);

      filter.removeWhere((element) =>
          !DateTime(element.tanggal!.year, element.tanggal!.month)
              .isAtSameMomentAs(DateTime(year, month)));

      // print('${filter.length} === ${dataProv.allowanceCategories[i]} ===');
      // print(
      //     '${dataProv.allowanceTableData[dataProv.allowanceCategories[i]]}%%%');

      if (filter.isNotEmpty) {
        // print('&&& ${dataProv.allowanceCategories[i]}');
        categoriesLabel.add(dataProv.allowanceCategories[i]);
        buffer.add(
          ChartData(
            dataProv.allowanceCategories[i],
            dataProv.allowanceCategoriesPrice[i].toDouble(),
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
          ),
        );
      }

      // print(categoriesLabel);
    }

    List<ExpenditureTable> dataP = List.from(dataProv.expenditureTableDataList);
    dataP.removeWhere((element) =>
        !DateTime(element.tanggal!.year, element.tanggal!.month)
            .isAtSameMomentAs(DateTime(now.year, now.month)));

    int resultP = 0;

    for (int i = 0; i < dataP.length; i++) {
      resultP += dataP[i].jumlah!;
    }

    buffer.add(
      ChartData(
        'Pengeluaran',
        resultP.toDouble(),
        Colors.redAccent,
      ),
    );
    // Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)

    // buffer.add(ChartData('Pemasukan', context.read<DataProvider>().income.toDouble(), Colors.lightGreenAccent,),);
    return buffer;
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.green]);
  final String x;
  final double y;
  final Color color;
}
