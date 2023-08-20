import 'package:digifest/data/global.dart';
import 'package:digifest/data/model/allowance_table.dart';
import 'package:digifest/data/model/expenditure_table.dart';
import 'package:digifest/data/model/income_table.dart';
import 'package:digifest/presentation/pages/edited_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class DetailPages extends StatelessWidget {
  const DetailPages({
    super.key,
    required this.transaction,
    this.id = 0,
    this.saldo = 0,
    required this.date,
    this.desc = '',
    this.dataAllowance,
  });
  final Transaction transaction;
  final int id;
  final int saldo;
  final DateTime date;
  final String desc;
  final List<AllowanceTable>? dataAllowance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Detail ${transaction == Transaction.allowance ? 'Allowance' : transaction == Transaction.expenditure ? 'Expenditure' : 'Income'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: transaction == Transaction.allowance
            ? ListView.builder(
                itemCount: dataAllowance!.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo : ${dataAllowance![index].jumlah!}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Tanggal : ${dataAllowance![index].tanggal!.day}/${dataAllowance![index].tanggal!.month}/${dataAllowance![index].tanggal!.year}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Description : ${dataAllowance![index].categories!}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditedPages(
                                  transaction: transaction,
                                  id: dataAllowance![index].id!,
                                  date: dataAllowance![index].tanggal!,
                                  saldo: dataAllowance![index].jumlah!,
                                  desc: dataAllowance![index].categories!,
                                ),
                              ),
                            );
                          },
                          child: const Text('Edit'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            databaseHelper
                                .removeAllowance(
                              AllowanceTable(
                                id: dataAllowance![index].id!,
                                tanggal: dataAllowance![index].tanggal!,
                                jumlah: dataAllowance![index].jumlah!,
                                categories: dataAllowance![index].categories!,
                              ),
                            )
                                .then(
                              (value) {
                                context
                                    .read<DataProvider>()
                                    .fetchAllowanceData();
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: const Text('Hapus'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saldo : $saldo',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Tanggal : ${date.day}/${date.month}/${date.year}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description : $desc',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          switch (transaction) {
                            case Transaction.allowance:
                              break;
                            case Transaction.expenditure:
                              // databaseHelper.updateExpenditure(
                              //   id,
                              //   ExpenditureTable(
                              //     tanggal: date,
                              //     jumlah: saldo,
                              //     description: desc,
                              //   ),
                              // );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditedPages(
                                    date: date,
                                    transaction: transaction,
                                    id: id,
                                    desc: desc,
                                    saldo: saldo,
                                  ),
                                ),
                              );
                              // context.read<DataProvider>().fetchExpenditureData();
                              break;
                            case Transaction.income:
                              databaseHelper.removeIncome(
                                IncomeTable(
                                  id: id,
                                  tanggal: date,
                                  jumlah: saldo,
                                  description: desc,
                                ),
                              );
                              context.read<DataProvider>().fetchIncomeData();
                              break;
                          }
                        },
                        child: const Text('Edit'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          switch (transaction) {
                            case Transaction.allowance:
                              break;
                            case Transaction.expenditure:
                              // databaseHelper.updateExpenditure(
                              //   id,
                              //   ExpenditureTable(
                              //     tanggal: date,
                              //     jumlah: saldo,
                              //     description: desc,
                              //   ),
                              // );
                              databaseHelper.removeExpenditure(
                                ExpenditureTable(
                                  id: id,
                                  tanggal: date,
                                  jumlah: saldo,
                                  description: desc,
                                ),
                              );
                              context
                                  .read<DataProvider>()
                                  .fetchExpenditureData();
                              break;
                            case Transaction.income:
                              databaseHelper.removeIncome(
                                IncomeTable(
                                  id: id,
                                  tanggal: date,
                                  jumlah: saldo,
                                  description: desc,
                                ),
                              );
                              context.read<DataProvider>().fetchIncomeData();
                              break;
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Hapus'),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

enum Transaction { allowance, expenditure, income }
