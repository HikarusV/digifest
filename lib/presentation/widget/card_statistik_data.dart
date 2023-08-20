import 'package:digifest/data/global.dart';
import 'package:flutter/material.dart';

class CardStatistikData extends StatelessWidget {
  const CardStatistikData(
      {Key? key,
      this.title = 'Title',
      required this.transactionCount,
      required this.nominal})
      : super(key: key);
  final String title;
  final int Function() transactionCount;
  final int Function() nominal;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text('${transactionCount()} transaksi'),
              ],
            ),
          ),
          Flexible(
            child: Text(
              '${rupiah.format(nominal())}.-',
            ),
          )
        ],
      ),
    );
  }
}
