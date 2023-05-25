import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/instruction_payment_method.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ListCaraBayarContainer extends StatelessWidget {
  const ListCaraBayarContainer({super.key, required this.listOfInstruction, this.debugColor = false});

  ///List of InstructionPaymentMethod
  final List<InstructionPaymentMethod> listOfInstruction;
  ///Gives color for debug purpose
  final bool debugColor;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(InstructionPaymentMethod i in listOfInstruction)
            paymentInstructionWidget(i, debugColor: debugColor)
      ],
    );
  }

  Widget paymentInstructionWidget(InstructionPaymentMethod model, {bool debugColor = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ///'Lewat ATM BCA'
        Text(
          'Lewat ${model.typePaymentMethod}',
          style: const TextStyle(fontWeight: semiBold, fontSize: 16),
        ),
        const SizedBox(height: 6,),

        ///Container contain instruction text
        Container(
          padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
          decoration: BoxDecoration(
            color: primaryLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryLightestColor),
          ),
          child: Container(
            color: (debugColor) ? Colors.amber : null,
            child: Markdown(
              data: model.instructionPaymentMethodDescription,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontWeight: regular, fontSize: 14),
                strong: const TextStyle(fontWeight: semiBold, fontSize: 14),
                blockSpacing: 1,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16,)
      ],
    );
  }
}