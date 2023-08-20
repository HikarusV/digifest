import 'package:digifest/data/model/allowance_table.dart';
import 'package:digifest/presentation/widget/row_date_input.dart';
import 'package:digifest/presentation/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/global.dart';
import '../../data/model/expenditure_table.dart';
import '../provider/data_provider.dart';
import 'detail_pages.dart';

class EditedPages extends StatefulWidget {
  const EditedPages({
    super.key,
    required this.transaction,
    this.id = 0,
    this.saldo = 0,
    required this.date,
    this.desc = '',
  });
  final Transaction transaction;
  final int id;
  final int saldo;
  final DateTime date;
  final String desc;

  @override
  State<EditedPages> createState() => _EditedPagesState();
}

class _EditedPagesState extends State<EditedPages> {
  DataDateTime dataDateTime = DataDateTime(DateTime.now());
  TextEditingController jumlah = TextEditingController();
  TextEditingController categories = TextEditingController();

  @override
  void initState() {
    // print('====== ${widget.id}');
    dataDateTime = DataDateTime(widget.date);
    jumlah.text = widget.saldo.toString();
    categories.text = widget.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text("Tanggal"),
                        ),
                        const Flexible(
                          flex: 0,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: RowDateInputs(
                            dateTime: dataDateTime,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text("Jumlah"),
                        ),
                        const Flexible(
                          flex: 0,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextInput(
                            controller: jumlah,
                            textHint: '50000',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text("Kategori"),
                        ),
                        const Flexible(
                          flex: 0,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextInput(
                            controller: categories,
                            textHint: 'Kategori',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  switch (widget.transaction) {
                    case Transaction.allowance:
                      databaseHelper
                          .updateAllowance(
                        widget.id,
                        AllowanceTable(
                          id: widget.id,
                          tanggal: dataDateTime.dateTime,
                          jumlah: int.tryParse(jumlah.text) ?? 0,
                          categories: categories.text,
                        ),
                      )
                          .then((value) {
                        // print(value);
                        context.read<DataProvider>().fetchAllowanceData();
                      });
                      break;
                    case Transaction.expenditure:
                      databaseHelper
                          .updateExpenditure(
                        widget.id,
                        ExpenditureTable(
                          id: widget.id,
                          tanggal: dataDateTime.dateTime,
                          jumlah: int.tryParse(jumlah.text) ?? 0,
                          description: widget.desc,
                        ),
                      )
                          .then((value) {
                        // print(value);
                        context.read<DataProvider>().fetchExpenditureData();
                      });
                      break;
                    case Transaction.income:
                      context.read<DataProvider>().fetchIncomeData();
                      break;
                  }
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
