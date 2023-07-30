import 'package:flutter/material.dart';

class RowDateInputs extends StatefulWidget {
  const RowDateInputs(
      {Key? key,
      this.hintText = 'Title',
      this.titleText = 'Masukkan',
      required this.dateTime})
      : super(key: key);
  final String hintText;
  final String titleText;
  final DataDateTime dateTime;

  @override
  State<RowDateInputs> createState() => _RowDateInputsState();
}

class _RowDateInputsState extends State<RowDateInputs> {
  late DateTime tanggalMasuk;

  @override
  void initState() {
    tanggalMasuk = widget.dateTime.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tanggalMasuk.day}/${tanggalMasuk.month}/${tanggalMasuk.year}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2030),
                  );

                  setState(() {
                    tanggalMasuk = result ?? tanggalMasuk;
                    widget.dateTime.dateTime = tanggalMasuk;
                  });
                },
                child: const Icon(Icons.calendar_month),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataDateTime {
  DateTime dateTime;

  DataDateTime(this.dateTime);
}
