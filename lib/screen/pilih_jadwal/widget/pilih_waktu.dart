import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/style/shadow_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PilihWaktuController extends ValueNotifier<List<int>>{
  PilihWaktuController(this._value) : super(_value){
    _initialValue = [..._value];
  }
  
  late List<int> _initialValue;
  List<int> _value;

  @override
  List<int> get value => _value;

  @override
  set value(List<int> newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    notifyListeners();
  }

  ScrollController? scrollController;

  set initialValue(List<int> newValue) {
    if(_initialValue == newValue) {
      return;
    }
    _initialValue = newValue;
    value = newValue;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for(int i = 0; i < value.length; i++){
        if(value[i] == 1){
          scrollController!.animateTo(
            4 + ((69 + 12) * i).toDouble(), 
            duration: const Duration(milliseconds: 1250), 
            curve: Curves.easeOutCubic
          );
          break;
        }
      }
    });
  }

  ///Revert back list to its initial value
  void revertBackList(){
    value = [..._initialValue];
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
}

class PilihWaktu extends StatefulWidget {
  const PilihWaktu({
    super.key, 
    required this.callback, 
    this.controller, 
    required this.startHour, 
    this.hourLimit, 
  });

  final void Function({int? startHour1, int? duration1}) callback;
  final PilihWaktuController? controller;
  final int startHour;
  final int? hourLimit;

  @override
  State<PilihWaktu> createState() => _PilihWaktuState();
}

class _PilihWaktuState extends State<PilihWaktu> {

  ///0 = Unavailable, 1 = Available, 2 = Choosen
  late ValueNotifier<List<int>> listDaftarSewa;
  // ValueNotifier<List<int>> listDaftarSewaDummy = ValueNotifier([0,1,1,0,1,0,1,1,1,1,1,1,0,0,1,1]  );
  //[0,1,1,0,1,0,1,1,1,1,1,1,0,0,1,1]
  ///Starting hour example 07:00
  // int startHour = 7;
  // int? hourLimit;
  // int duration = 0;
  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
  );

  @override
  void initState() {
    super.initState();

    listDaftarSewa = (widget.controller != null) 
        ? widget.controller! 
        : ValueNotifier([0,1,1,0,1,0,1,1,1,1,1,1,0,0,1,1]  );
    
    (listDaftarSewa as PilihWaktuController).scrollController = scrollController;
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // for(int i = 0; i < listDaftarSewa.value.length; i++){
      //   if(listDaftarSewa.value[i] == 1 && i != 0){
      //     scrollController.animateTo(
      //       4 + ((69 + 12) * i).toDouble(), 
      //       duration: const Duration(milliseconds: 1250), 
      //       curve: Curves.easeOutCubic
      //     );
      //     break;
      //   }
      // }

      widget.callback(
        startHour1: null,
        duration1: null,
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {

    int startHour = widget.startHour;
    int? hourLimit = widget.hourLimit;
    int duration = 0;

    ///Outside Border
    return Stack(
      children: [

        ///Container, Text, Button and more...
        Container(
          // height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: primaryLightestColor, ),
            borderRadius: BorderRadius.circular(10)
          ),

          ///Inside Clip
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryBaseColor
            ),

            child: Column(
              children: [

                ///ScrollView & Scrollbar
                Scrollbar(
                  scrollbarOrientation: ScrollbarOrientation.top,
                  controller: scrollController,
                  thickness: 4,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: ValueListenableBuilder(
                      valueListenable: listDaftarSewa,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              color: primaryLightColor,
                              height: 25,

                              ///Hours
                              child: Row(
                                children: [
                                  for(int i = 0; i < listDaftarSewa.value.length; i++)
                                    SizedBox(
                                      ///69 box + 12 right padding
                                      width: 69 + 12,
                                      child: Text(
                                        '${NumberFormat('00').format(startHour+i)}:00',
                                        style: const TextStyle(
                                          fontWeight: semiBold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                
                            ///Button ('Unavailable', 'Available', 'Choosen')
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
                              child: Row(
                                children: [
                                  for(int i = 0; i < listDaftarSewa.value.length; i++)
                                  
                                    SizedBox(
                                      // color: Colors.amber,
                                      ///69 box + 12 right padding
                                      width: (69 + 12),
                                      child: FittedBox(
                                        alignment: Alignment.topLeft,
                                        fit: BoxFit.scaleDown,
                                        child: Builder(
                                          builder: (context) {
                                            
                                            switch(listDaftarSewa.value[i]){
                
                                              ///If 'is Unavailable(Gray/Black)'
                                              case 0: {
                                                return Container(
                                                  width: 69,
                                                  height: 69,
                                                  margin: const EdgeInsets.only(top: 12),
                                                  alignment: Alignment.bottomRight,
                                                  padding: const EdgeInsets.only(bottom: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: primaryLighterColor
                                                  ),
                                                  child: FittedBox(
                                                    fit: BoxFit.none,
                                                    child: SvgPicture.asset(
                                                      'assets/icon/Lock.svg',
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                  ),
                                                );
                                              }
                
                                              ///If 'is Available(Blue)'
                                              case 1: {
                                                return Stack(
                                                  children: [
                                                    Container(
                                                      width: 69,
                                                      height: 69,
                                                      margin: const EdgeInsets.only(top: 12),
                                                      padding: const EdgeInsets.only(top: 6),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(color: infoColor),
                                                        color: infoDarkColor
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          const Text(
                                                            'Tersedia',
                                                            style: TextStyle(
                                                              fontWeight: semiBold,
                                                              fontSize: 12,
                                                              color: infoDarkerColor
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment.bottomRight,
                                                            child: SvgPicture.asset(
                                                              'assets/icon/Unlocked.svg',
                                                              height: 35,
                                                              width: 35,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                
                                                    Positioned.fill(
                                                      top: 12,
                                                      child: Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                          borderRadius: BorderRadius.circular(5),
                                                          onTap: (){
                                                            for(int i = 0; i < listDaftarSewa.value.length; i++){
                                                              if (listDaftarSewa.value[i] == 2){
                                                                listDaftarSewa.value[i] = 1;
                                                              }
                                                            }
                                                            listDaftarSewa.value[i] = 2;

                                                            ///Send data
                                                            widget.callback(
                                                              startHour1: startHour + i, 
                                                              duration1: 1,
                                                            );
                                                            
                                                            listDaftarSewa.value = [...listDaftarSewa.value];
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }

                                              ///If 'is Choosen(Green)'
                                              case 2: {
                                                
                                                int length = listDaftarSewa.value.length;
                                                bool isBegin = false;
                                                bool isEnd = false;
                
                                                if((i > 0 && listDaftarSewa.value[i - 1] != 2) || i == 0){
                                                  isBegin = true;
                                                }
                                                if((i < length - 1 && listDaftarSewa.value[i + 1] != 2) || i == length - 1){
                                                  isEnd = true;
                                                }
                
                                                return Stack(
                                                  children: [
                                                    SizedBox(
                                                      // color: Colors.green,
                                                      width: 69 + 12,
                                                      child: FittedBox(
                                                        alignment: Alignment.bottomLeft,
                                                        fit: BoxFit.scaleDown,
                                                        child: Container(
                                                          width: 69 + ((isEnd) ? 0 : 12),
                                                          height: 69,
                                                          margin: const EdgeInsets.only(top: 12),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular((isBegin) ? 5 : 0),
                                                              topRight: Radius.circular((isEnd) ? 5 : 0),
                                                              bottomLeft: Radius.circular((isBegin) ? 5 : 0),
                                                              bottomRight: Radius.circular((isEnd) ? 5 : 0)
                                                            ),
                                                            color: success2Color,
                                                            // border: Border.all(color: success2Color)
                                                          ),
                                                          child: FittedBox(
                                                            alignment: (isBegin && !isEnd) ? Alignment.centerRight : (isEnd && !isBegin) ? Alignment.centerLeft : Alignment.center,
                                                            fit: BoxFit.none,
                                                            child: Container(
                                                              width: (isBegin && !isEnd) ? 69 + 12 - 1 : (isEnd && !isBegin) ? 69 - 1 : (isBegin && isEnd) ? 69 - 2 : 69 + 12,
                                                              height: 67,
                                                              decoration: BoxDecoration(
                                                                color: success2DarkColor,
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular((isBegin) ? 5 : 0),
                                                                  topRight: Radius.circular((isEnd) ? 5 : 0),
                                                                  bottomLeft: Radius.circular((isBegin) ? 5 : 0),
                                                                  bottomRight: Radius.circular((isEnd) ? 5 : 0)
                                                                ),
                                                              ),
                                                              child: (isBegin) ? FittedBox(
                                                                alignment: Alignment.bottomLeft,
                                                                fit: BoxFit.none,
                                                                child: SvgPicture.asset(
                                                                  'assets/icon/Check.svg',
                                                                  height: 49,
                                                                  width: 49,
                                                                ),
                                                              ) : const SizedBox(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                
                                                    (isEnd) ? Positioned(
                                                      right: 4,
                                                      top: 4,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 22,
                                                            width: 22,
                                                            decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: error2DarkerColor,
                                                              border: Border.all(color: error2Color)
                                                            ),
                                                            child: FittedBox(
                                                              fit: BoxFit.none,
                                                              child: SvgPicture.asset(
                                                                'assets/icon/X.svg',
                                                                height: 22,
                                                                width: 22,
                                                              ),
                                                            ),
                                                          ),
                
                                                          Positioned.fill(
                                                            child: Material(
                                                              color: Colors.transparent,
                                                              child: InkWell(
                                                                customBorder: const CircleBorder(),
                                                                onTap: (){
                                                                  for(int j = 0; j < listDaftarSewa.value.length; j++){
                                                                    if(listDaftarSewa.value[j] == 2){
                                                                      listDaftarSewa.value[j] = 1;
                                                                    }
                                                                  }

                                                                  ///Send data
                                                                  widget.callback(
                                                                    startHour1: null, 
                                                                    duration1: null,
                                                                  );

                                                                  listDaftarSewa.value = [...listDaftarSewa.value];
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ) : const SizedBox()
                                                  ],
                                                );
                                              }
                
                                              default: {
                                                return const SizedBox();
                                              }
                                            }
                                          }
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: listDaftarSewa,
                        builder: (context, value, child) {
                          
                          ///How many 'Choosen hour' count
                          int choosenCount = 0;
                          ///Possibility to add more hour from base hour
                          bool possibleAddHour = false;
                          ///Index of position of the first 'Choosen Hour'
                          int firstChoosen = -1;
                          ///Index of position of the last 'Choosen Hour'
                          int lastChoosen = -1;

                          for(int i = 0; i < listDaftarSewa.value.length; i++){
                            if(listDaftarSewa.value[i] == 2){
                              choosenCount += 1;
                              lastChoosen = i;
                              if(i < listDaftarSewa.value.length - 1 && listDaftarSewa.value[i + 1] == 1){
                                if(hourLimit == null || (choosenCount < hourLimit)){
                                  possibleAddHour = true;
                                }
                              }
                              if(firstChoosen == -1){
                                firstChoosen = i;
                              }
                            }
                          }

                          duration = choosenCount;

                          ///If duration = 0
                          if(choosenCount == 0){
                            return const SizedBox();
                          }

                          ///If duration != 0
                          else{
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                ///Hour Button and Info Text
                                Row(
                                  children: [

                                    ///Left Button
                                    Stack(
                                      children: [
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: primaryLighterColor,
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: (choosenCount > 1) ? [
                                              dropShadow,
                                            ] : null,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icon/Caret-Left.svg',
                                            colorFilter: ColorFilter.mode(
                                              (choosenCount > 1) ? Colors.white : primaryLightestColor,
                                              BlendMode.srcATop
                                            ),
                                            // color: (choosenCount > 1) ? Colors.white : primaryLightestColor,
                                          ),
                                        ),

                                        Positioned.fill(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(5),
                                              onTap: (choosenCount > 1) ? (){
                                                listDaftarSewa.value[lastChoosen] = 1;

                                                ///Send data
                                                widget.callback(
                                                  startHour1: firstChoosen + startHour, 
                                                  duration1: duration - 1,
                                                );

                                                listDaftarSewa.value = [...listDaftarSewa.value];
                                              } : null,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(width: 32,),

                                    ///Duration Text
                                    Text(
                                      '$choosenCount Jam',
                                      style: const TextStyle(
                                        fontWeight: semiBold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(width: 32,),

                                    ///Right Button
                                    Stack(
                                      children: [
                                        Container(
                                          height: 24,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            color: primaryLighterColor,
                                            borderRadius: BorderRadius.circular(5),
                                            boxShadow: (possibleAddHour) ? [
                                              dropShadow,
                                            ] : null,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icon/Caret-Right.svg',
                                            colorFilter: ColorFilter.mode(
                                              (possibleAddHour) ? Colors.white : primaryLightestColor, 
                                              BlendMode.srcATop
                                            ),
                                            // color: (possibleAddHour) ? Colors.white : primaryLightestColor,
                                          ),
                                        ),

                                        Positioned.fill(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(5),
                                              onTap: (possibleAddHour) ? (){
                                                listDaftarSewa.value[lastChoosen + 1] = 2;

                                                ///Send data
                                                widget.callback(
                                                  startHour1: firstChoosen + startHour, 
                                                  duration1: duration + 1,
                                                );

                                                listDaftarSewa.value = [...listDaftarSewa.value];
                                              } : null,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                ///Hour Choosen Text
                                Container(
                                  height: 24,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: primaryLighterColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: success2DarkColor),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icon/Clock-2.svg',
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcATop
                                        ),
                                        height: 18,
                                        width: 18,
                                      ),

                                      const SizedBox(width: 16,),

                                      Text(
                                        //Example 07:00 - 09:00
                                        '${NumberFormat('00').format(startHour + firstChoosen)}:00 - ${NumberFormat('00').format(startHour + lastChoosen + 1)}:00',
                                        style: const TextStyle(
                                          fontWeight: semiBold,
                                          fontSize: 14
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                        }
                      ),

                      const SizedBox(height: 16,),

                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/Info-Circle.svg',
                            height: 24,
                            width: 24,
                          ),

                          const SizedBox(width: 16,),

                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: listDaftarSewa,
                              builder: (context, value, child) {
                          
                                bool isChoosen = false;
                                for(int i = 0; i < listDaftarSewa.value.length; i++){
                                  if(listDaftarSewa.value[i] == 2){
                                    isChoosen = true;
                                    break;
                                  }
                                }
                          
                                return Text(
                                  // (isChoosen) ? 'Pilih Durasi' : 'Pilih waktu yang tersedia',
                                  (isChoosen) ? 'Maximal durasi yang dapat dipilih adalah ${widget.hourLimit} jam' : 'Pilih waktu yang tersedia',
                                  style: const TextStyle(
                                    fontWeight: regular,
                                    fontSize: 14,
                                  ),
                                );
                              }
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),

        ValueListenableBuilder(
          valueListenable: widget.controller!,
          builder: (context, value, child) {

            return (widget.controller != null && widget.controller!.isLoading)
                ? Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0x7E000000),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.none,
                      child: CircularProgressIndicator(
                        backgroundColor: infoColor, color: Colors.white,
                      ),
                    ),
                  ),
                )
                : const SizedBox();
            
          }
        )
      ],
    );
  }
}