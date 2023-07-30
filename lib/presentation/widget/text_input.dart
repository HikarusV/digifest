import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.controller,
    this.title = '',
    this.textHint = 'Text Hint',
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final String textHint;
  final int maxLines;
  final int minLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: (minLines == 1) ? 50 : minLines * 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(),
                ),
              ),
              TextField(
                controller: controller,
                maxLines: maxLines,
                minLines: minLines,
                maxLength: maxLength,
                maxLengthEnforcement:
                    (maxLength == null) ? null : MaxLengthEnforcement.enforced,
                style: TextStyle(
                  // fontStyle: titleSmall.fontStyle,
                  // fontSize: titleSmall.fontSize,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                decoration: InputDecoration(
                  hintText: textHint,
                  // hintStyle: hintTitle,
                  contentPadding: const EdgeInsets.only(
                      top: 13, bottom: 12, left: 15, right: 15),
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
