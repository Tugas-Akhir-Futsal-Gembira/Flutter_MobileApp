import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_chip.dart';

class FilterRiwayat extends StatefulWidget {
  const FilterRiwayat({super.key, this.onTap});

  ///0 = week, 1 = month, 2 = year
  final Function(int value)? onTap;

  @override
  State<FilterRiwayat> createState() => _FilterRiwayatState();
}

class _FilterRiwayatState extends State<FilterRiwayat> {

  CustomChipController weekController = CustomChipController(isActive: true);
  CustomChipController monthController = CustomChipController(isActive: false);
  CustomChipController yearController = CustomChipController(isActive: false);

  @override
  Widget build(BuildContext context) {

    List<String> filterText = [
      '1 Minggu Terakhir', '1 Bulan Terakhir', '1 Tahun Terakhir'
    ];



    return Container(
      height: 28 + 16 + 16, //16 = Margin top and bottom
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            ///1 Minggu Terakhir
            CustomChip(
              value: filterText[0],
              controller: weekController,
              onTap: () {
                changeFilter(0);
              },
            ),
            const SizedBox(width: 16,),

            ///1 Bulan Terakhir
            CustomChip(
              value: filterText[1],
              controller: monthController,
              onTap: () {
                changeFilter(1);
              },
            ),
            const SizedBox(width: 16,),

            ///1 Tahun Terakhir
            CustomChip(
              value: filterText[2],
              controller: yearController,
              onTap: () {
                changeFilter(2);
              },
            ),
          ],
        ),
      ),
    );

  }

  ///0 for week,
  ///1 for month,
  ///2 for year
  void changeFilter(int value){
    weekController.isActive = false;
    monthController.isActive = false;
    yearController.isActive = false;
    switch(value){
      case 0: {
        weekController.isActive = true;
        if(widget.onTap != null){
          widget.onTap!(0);
        }
        break;
      }
      case 1: {
        monthController.isActive = true;
        if(widget.onTap != null){
          widget.onTap!(1);
        }
        break;
      }
      case 2: {
        yearController.isActive = true;
        if(widget.onTap != null){
          widget.onTap!(2);
        }
        break;
      }
      default: {
        
      }
    }
  }
}