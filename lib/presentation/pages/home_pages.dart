import 'package:digifest/common/state.dart';
import 'package:digifest/data/global.dart';
import 'package:digifest/presentation/pages/allowance_pages.dart';
import 'package:digifest/presentation/pages/profile_pages.dart';
import 'package:digifest/presentation/provider/data_provider.dart';
import 'package:digifest/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<DataProvider>(context, listen: false)
      ..fetchAllowanceData()
      ..fetchExpenditureData()
      ..fetchIncomeData());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage('assets/twh.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 60,
                  height: 40,
                  decoration: const BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage('assets/pkm.png'),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 40,
                  decoration: const BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage('assets/std-black.png'),
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Halo!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.watch<UserProvider>().getName(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePages(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.person),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // border: Border.all(),
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 100,
                      alignment: Alignment.center,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          const Positioned(
                            top: 20,
                            left: 20,
                            child: Text(
                              "Saldo Total",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            bottom: 20,
                            child: Text(
                              rupiah.format(context
                                      .watch<DataProvider>()
                                      .income -
                                  context.watch<DataProvider>().expenditure),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
                            label: Row(
                              children: [
                                const Icon(Icons.arrow_upward),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(rupiah.format(
                                    context.watch<DataProvider>().income))
                              ],
                            ),
                            backgroundColor: Colors.green[200]),
                        Chip(
                            label: Row(
                              children: [
                                const Icon(Icons.arrow_downward),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(rupiah.format(
                                    context.watch<DataProvider>().expenditure))
                              ],
                            ),
                            backgroundColor: Colors.red[200]),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  color: Colors.black38,
                                  blurRadius: 3,
                                  spreadRadius: 0.1,
                                ),
                              ],
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.white,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(90),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AllowanceTransact(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  // alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Consumer<DataProvider>(builder: (context, value, _) {
                            if (value.allowanceDataState ==
                                ResultState.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (value.allowanceDataState ==
                                ResultState.hasData) {
                              return ListView.builder(
                                itemCount: value.allowanceCategories.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                            value.allowanceCategories[index]),
                                      ),
                                      const Flexible(
                                        flex: 0,
                                        child: SizedBox(
                                          width: 8,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 0,
                                        child: Text(
                                          rupiah.format(value
                                              .allowanceCategoriesPrice[index]),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else if (value.allowanceDataState ==
                                ResultState.noData) {
                              return const Center(
                                child: Text('Data Kosong'),
                              );
                            } else {
                              return const Center(
                                child: Text('Ada masalah saat memuat data'),
                              );
                            }
                          }),
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
                    Consumer<DataProvider>(builder: (context, value, _) {
                      if (value.expenditureDataState == ResultState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (value.expenditureDataState ==
                          ResultState.hasData) {
                        return ListView.builder(
                          itemCount: value.expenditureTableDataList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${value.expenditureTableDataList[index].tanggal!.day}/${value.expenditureTableDataList[index].tanggal!.month}",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const Flexible(
                                  flex: 0,
                                  child: SizedBox(
                                    width: 8,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    "${value.expenditureTableDataList[index].description}",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const Flexible(
                                  flex: 0,
                                  child: SizedBox(
                                    width: 8,
                                  ),
                                ),
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    rupiah.format(value
                                        .expenditureTableDataList[index]
                                        .jumlah),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else if (value.expenditureDataState ==
                          ResultState.noData) {
                        return const Center(
                          child: Text('Data Kosong'),
                        );
                      } else {
                        return const Center(
                          child: Text('Ada masalah saat memuat data'),
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
