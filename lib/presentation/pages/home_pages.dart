import 'package:digifest/data/global.dart';
import 'package:digifest/data/model/expenditure_table.dart';
import 'package:digifest/data/model/income_table.dart';
import 'package:digifest/presentation/pages/transact_pages.dart';
import 'package:digifest/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Halo!",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.watch<UserProvider>().getName(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TransactPages(),
                            ));
                      },
                      child: const Text("Tambah Saldo"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  height: 100,
                  alignment: Alignment.center,
                  child: const Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Text("Saldo Total"),
                      ),
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: Text(
                          "Rp 1.000.000",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(
                        label: const Row(
                          children: [
                            Icon(Icons.arrow_upward),
                            SizedBox(
                              width: 10,
                            ),
                            Text("20.000")
                          ],
                        ),
                        backgroundColor: Colors.green[200]),
                    Chip(
                        label: const Row(
                          children: [
                            Icon(Icons.arrow_downward),
                            SizedBox(
                              width: 10,
                            ),
                            Text("20.000")
                          ],
                        ),
                        backgroundColor: Colors.red[200]),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(),
                        ),
                        // alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                      ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text("Pengeluaran Pokok"),
                              ),
                              Flexible(
                                flex: 0,
                                child: SizedBox(
                                  width: 8,
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "500.000",
                                    textAlign: TextAlign.end,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Lihat transaksi anda disini"),
                const SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "05/07",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: SizedBox(
                            width: 8,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            "Pengeluaran Pokok",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: SizedBox(
                            width: 8,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "500.000",
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
