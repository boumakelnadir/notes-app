import 'package:chatapp2/widget/custom_text.dart';
import 'package:flutter/material.dart';

class QuestionNavigate extends StatelessWidget {
  const QuestionNavigate({
    super.key,
    required this.textBotton,
    required this.textQuestion,
    this.navigator,
    this.fontSize,
  });
  final String textBotton;
  final String textQuestion;
  final Widget? navigator;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: textQuestion,
          fontSize: fontSize == null ? 18 : fontSize!,
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => navigator == null
              ? Navigator.pop(context)
              : Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => navigator!),
                ),
          child: CustomText(
            text: textBotton,
            fontSize: fontSize == null ? 18 : fontSize!,
            color: Colors.blue,
          ),
        )
      ],
    );
  }
}
