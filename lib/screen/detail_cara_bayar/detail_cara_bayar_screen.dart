
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/instruction_payment_method.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_cara_bayar/widget/list_cara_bayar_container.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailCaraBayarScreen extends StatefulWidget {
  const DetailCaraBayarScreen({super.key});

  @override
  State<DetailCaraBayarScreen> createState() => _DetailCaraBayarScreenState();
}

class _DetailCaraBayarScreenState extends State<DetailCaraBayarScreen> {

  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ScrollController cardScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      refreshDummy();
    });
  }

  @override
  Widget build(BuildContext context) {

    ScrollController scrollController = ScrollController();
    ValueNotifier<double> opacity = ValueNotifier(0);

    ///Dummy Data
    String paymentMethodName = 'Virtual Account BCA';
    int totalPrice = 74439;
    String paymentCode = '1234567890123456';
    DateTime paymentDueDateTime = DateTime(2023, 1, 21, 8, 15);

    List<InstructionPaymentMethod> listOfInstruction = [
      InstructionPaymentMethod(
        instructionPaymentMethodId: 1, 
        paymentMethodsId: 1, 
        typePaymentMethod: 'ATM BCA', 
        instructionPaymentMethodDescription: '1. Masukkan PIN anda\n2. Pilih menu **Penarikan Tunai** atau **Transaksi Lainnya**\n3. Pilih **Transfer**\n4. Pilih **Ke Rek BCA Virtual Account**\n5. Masukkan **$paymentCode** (nomor kode pembayaran) dan klik **Benar**\n6. Cek detail transaksi dan pilih **Ya**\n7. Transaksi berhasil'
      ),
      InstructionPaymentMethod(
        instructionPaymentMethodId: 1, 
        paymentMethodsId: 1, 
        typePaymentMethod: 'BCA Mobile', 
        instructionPaymentMethodDescription: '1. Masukkan PIN anda\n2. Pilih menu **Penarikan Tunai** atau **Transaksi Lainnya**\n3. Pilih **Transfer**\n4. Pilih **Ke Rek BCA Virtual Account**\n5. Masukkan **$paymentCode** (nomor kode pembayaran) dan klik **Benar**\n6. Cek detail transaksi dan pilih **Ya**\n7. Transaksi berhasil'
      ),
    ];


    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/football doodle.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xFA2F2F2F), BlendMode.srcATop)
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        ///AppBar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 71,
          titleSpacing: 20,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: SvgPicture.asset('assets/icon/Caret-Left.svg')
          ),
          title: const Text(
            'Cara Bayar',
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
          flexibleSpace: Column(
            children: [
              Container(
                color: primaryBaseColor,
                width: double.infinity,
                child: const SafeArea(child: SizedBox(),),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: opacity,
                  builder: (context, value, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryBaseColor,
                            primaryBaseColor.withOpacity(opacity.value)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),

        ///Body
        body: RefreshIndicator(
          onRefresh: () async{

          },
          child: LayoutBuilder(
            builder: (p0context, p1constraint)  {
              return SizedBox(
                height: p1constraint.maxHeight,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      
                      ///Image with payment method name, total price, payment code, payment due date time
                      Stack(
                        children: [
                          
                          ///Image
                          AspectRatio(
                            aspectRatio: 428/239,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage('assets/image/cara_bayar/debit credit card wallpaper.jpg'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.7), 
                                    BlendMode.srcATop
                                  ),
                                )
                              ),
                            ),
                          ),
                      
                          ///Bunch of Data Text
                          Positioned.fill(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                              ///For dividing notch(and System UI) and content(such as PaymentMethod, TotalPrice)
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).viewPadding.top + 71, //notch and systemUI + AppBar height
                                  ),
                                  Expanded(
                                    child: ValueListenableBuilder(
                                      valueListenable: isLoading,
                                      builder: (context, value, child) {
                                        
                                        (isLoading.value == true)
                                            ? null
                                            : Future.delayed( const Duration(milliseconds: 0),() {
                                              if(cardScrollController.hasClients){
                                                cardScrollController.animateTo(
                                                  18, 
                                                  duration: const Duration(seconds: 2), 
                                                  curve: Curves.easeOutCubic
                                                );
                                              }
                                            },);
                            
                                        return (isLoading.value == true)
                                            ? const SizedBox()
                                            : SizedBox(
                                              width: double.infinity,
                                              ///Bunch of field data
                                              child: LayoutBuilder(
                                                builder: (p0context1, p1constraint1) {
                                                  return SingleChildScrollView(
                                                    controller: cardScrollController,
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        minHeight: p1constraint1.maxHeight
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(height: 18,),
                      
                                                          ///First Row
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text(
                                                                      'Metode Pembayaran',
                                                                      style: TextStyle(
                                                                        fontWeight: regular,
                                                                        fontSize: 14
                                                                      ),
                                                                    ),
                                                                    ///'Virtual Account BCA
                                                                    Text(
                                                                      paymentMethodName,
                                                                      style: const TextStyle(
                                                                        fontWeight: semiBold,
                                                                        fontSize: 16
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(width: 32,),
                            
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text(
                                                                      'Total Harga',
                                                                      style: TextStyle(
                                                                        fontWeight: regular,
                                                                        fontSize: 14
                                                                      ),
                                                                    ),
                                                                    ///Rp 79.999
                                                                    Text(
                                                                      customCurrencyFormat(totalPrice),
                                                                      style: const TextStyle(
                                                                        fontWeight: semiBold,
                                                                        fontSize: 16
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),    ///End of First Row
                                                          const SizedBox(height: 16,),
                      
                                                          ///Second Row
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text(
                                                                      'Kode Pembayaran',
                                                                      style: TextStyle(
                                                                        fontWeight: regular,
                                                                        fontSize: 14
                                                                      ),
                                                                    ),
                                                                    ///1234567890123456
                                                                    Text(
                                                                      paymentCode,
                                                                      style: const TextStyle(
                                                                        fontWeight: semiBold,
                                                                        fontSize: 16
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(width: 32,),
                            
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text(
                                                                      'Batas Pembayaran',
                                                                      style: TextStyle(
                                                                        fontWeight: regular,
                                                                        fontSize: 14
                                                                      ),
                                                                    ),
                                                                    ///21 Januari 2023, 08:15
                                                                    Text(
                                                                      customDateFormat(paymentDueDateTime),
                                                                      style: const TextStyle(
                                                                        fontWeight: semiBold,
                                                                        fontSize: 16
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )   ///End of Second Row
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              ),
                                            );
                                      }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, value, child) {
                          return (isLoading.value) 
                              ? const LinearProgressIndicator(
                                color: infoColor,
                                backgroundColor: primaryLightestColor,
                              )
                              : Padding(
                                padding: const EdgeInsets.all(16),
                                child: ListCaraBayarContainer(listOfInstruction: listOfInstruction, debugColor: false,),
                              );
                        }
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  void refreshDummy(){
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), ()=> isLoading.value = false);
  }
}