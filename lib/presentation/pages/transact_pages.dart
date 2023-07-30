import 'package:digifest/presentation/widget/text_input.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class TransactPages extends StatefulWidget {
  const TransactPages({super.key});

  @override
  State<TransactPages> createState() => _TransactPagesState();
}

class _TransactPagesState extends State<TransactPages> {
  int _currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 0,
                child: MaterialSegmentedControl(
                  children: const {
                    0: Text("Pemasukan"),
                    1: Text("Pengeluaran"),
                  },
                  selectionIndex: _currentSelection,
                  borderColor: Colors.black,
                  selectedColor: Colors.purple,
                  unselectedColor: Colors.white,
                  horizontalPadding: const EdgeInsets.only(),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                  unselectedTextStyle: const TextStyle(color: Colors.purple),
                  borderWidth: 0.7,
                  borderRadius: 12,
                  onSegmentTapped: (index) {
                    setState(() {
                      _currentSelection = index;
                    });
                  },
                ),
              ),
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
                          child: TextInput(controller: TextEditingController()),
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
                          child: TextInput(controller: TextEditingController()),
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
                          child: Text("Keterangan"),
                        ),
                        const Flexible(
                          flex: 0,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextInput(controller: TextEditingController()),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
