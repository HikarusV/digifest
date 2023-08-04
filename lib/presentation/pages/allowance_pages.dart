import 'package:digifest/data/model/allowance_table.dart';
import 'package:digifest/data/model/expenditure_table.dart';
import 'package:digifest/data/model/income_table.dart';
import 'package:digifest/presentation/provider/data_provider.dart';
import 'package:digifest/presentation/widget/row_date_input.dart';
import 'package:digifest/presentation/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:provider/provider.dart';

import '../../data/global.dart';

class AllowanceTransact extends StatefulWidget {
  const AllowanceTransact({super.key});

  @override
  State<AllowanceTransact> createState() => _AllowanceTransactState();
}

class _AllowanceTransactState extends State<AllowanceTransact> {
  DataDateTime dataDateTime = DataDateTime(DateTime.now());
  TextEditingController jumlah = TextEditingController();
  TextEditingController categories = TextEditingController();
  String cat = 'Categories';

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
                          child: GestureDetector(
                            onTap: () {
                              String buffer = '';
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: ListView.builder(
                                      itemCount: context
                                              .read<DataProvider>()
                                              .allowanceCategories
                                              .length +
                                          1,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 16,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          border: Border.all(),
                                                        ),
                                                      ),
                                                      TextField(
                                                        controller: categories,
                                                        maxLines: 1,
                                                        minLines: 1,
                                                        style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onPrimaryContainer,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          hintText:
                                                              'Kategori Baru',
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  top: 8,
                                                                  bottom: 8,
                                                                  left: 15,
                                                                  right: 15),
                                                          isDense: true,
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      if (categories
                                                          .text.isNotEmpty) {
                                                        buffer =
                                                            categories.text;
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.add))
                                              ],
                                            ),
                                          );
                                        } else {
                                          String items = context
                                              .read<DataProvider>()
                                              .allowanceCategories[index - 1];
                                          return InkWell(
                                            onTap: () {
                                              buffer = items;
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 16),
                                              child: Text(
                                                items,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ).then((value) {
                                if (buffer.isNotEmpty) {
                                  setState(() {
                                    cat = buffer;
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cat),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
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
                  if (int.tryParse(jumlah.text) != null &&
                      cat != 'Categories') {
                    databaseHelper
                        .insertAllowance(
                      AllowanceTable(
                        tanggal: dataDateTime.dateTime,
                        jumlah: int.parse(jumlah.text),
                        categories: cat,
                      ),
                    )
                        .then((value) {
                      context.read<DataProvider>().fetchAllowanceData();
                      Navigator.pop(context);
                    });
                  }
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
