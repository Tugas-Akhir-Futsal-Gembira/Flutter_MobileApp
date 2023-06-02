import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

///Controller of CustomDropdownButton
class CustomDropdownButtonController extends ValueNotifier{
  CustomDropdownButtonController({
    required List<String> itemString, 
    required int? indexItemString,
  }) : super(null){
    _itemString = itemString;
    _indexItemString = indexItemString;
  }

  late List<String> _itemString;
  late int? _indexItemString;

  List<String> get itemString => _itemString;
  int? get indexItemString => _indexItemString;

  void findIndexItemString(String? value){

    if(value == null){
      return;
    }

    for(int i = 0; i < itemString.length; i++){
      if(itemString[i] == value){
        _indexItemString = i;
        notifyListeners();
      }
    }
  }
  
}

///Widget with customDropdown + controller(ValueNotifier) + title
class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    this.controller,
    required this.context,
    this.title,
    this.value,
    required this.onChanged,
    required this.itemString,
    this.onTap,
    this.isExpanded = false,
  });

  final BuildContext context;
  final CustomDropdownButtonController? controller;
  final String? title;
  final String? value;
  final void Function(String? value)? onChanged;
  final List<String> itemString;
  final Function()? onTap;
  final bool isExpanded;


  @override
  Widget build(BuildContext context) {

    CustomDropdownButtonController tempController = (controller != null)
        ? controller!
        : CustomDropdownButtonController(itemString: itemString, indexItemString: null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ///Title with SizedBox(Margin Bottom)
        (title != null) 
            ? Column(
              children: [
                Text(
                  title!,
                  style: const TextStyle(fontWeight: regular, fontSize: 16),
                ),

                const SizedBox(height: 12,)
              ],
            )
            : const SizedBox(),

        ///CustomDropdownButton with ValueNotifier(controller)
        ValueListenableBuilder(
          valueListenable: tempController,
          builder: (context, _, child) {
            return CustomDropdownButtonExtends(
              context: context,
              value: (controller != null && controller!.indexItemString != null) 
                  ? controller!.itemString[controller!.indexItemString!] 
                  : value,
              itemString: (controller != null) ? controller!.itemString : itemString,
              isExpanded: isExpanded,
              onChanged: onChanged,
              onTap: onTap,
            );
          }
        ),
      ],
    );
  }
}

///Create custom DropdownButton with custom UI
class CustomDropdownButtonExtends extends DropdownButton<String>{
  CustomDropdownButtonExtends({
    super.key, 
    required this.context,
    super.value,
    required super.onChanged,
    required this.itemString,
    super.onTap,
    super.isExpanded,
  }) : super(
    icon: const SizedBox(),
    underline: const SizedBox(),
    borderRadius: BorderRadius.circular(10),
    

    items: itemString.map<DropdownMenuItem<String>>((e) {
      return DropdownMenuItem<String>(
        value: e,
        child: Text(e, style: const TextStyle(fontWeight: medium, fontSize: 16, color: Colors.black),)
      );
    }).toList(),

    ///Builder for selected dropdownButton
    selectedItemBuilder: (context){
      return itemString.map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20, right: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [

              ///Text value
              Expanded(
                child: Text(
                  e, 
                  style: const TextStyle(fontWeight: medium, fontSize: 16, color: Colors.white),
                ),
              ),

              ///Arrow down
              SvgPicture.asset('assets/icon/Caret-Down.svg', height: 24, width: 24, fit: BoxFit.none,),
            ],
          )
        );
      }).toList();
    }
  );

  final List<String> itemString;
  final BuildContext context;


}