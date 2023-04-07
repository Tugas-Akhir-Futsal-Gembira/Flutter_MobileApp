import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/beranda_appbar.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/beranda_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/pengaturan_appbar.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/pengaturan_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/riwayat_penyewaan/riwayat_penyewaan_appbar.dart';
import 'package:flutter_application_futsal_gembira/screen/riwayat_penyewaan/riwayat_penyewaan_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.indexChoosen = 0});

  ///To choose between 0.Beranda, 1.Riwayat, 2.Pengaturan.
  ///
  ///Other than that will be goes to 0.Beranda.
  final int indexChoosen;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  ///Index that used for bottomNavigation
  int navigationIndex = 0;

  @override
  void initState() {
    if(widget.indexChoosen < 0 || widget.indexChoosen > 2){
      navigationIndex = 0;
    }
    else{
      navigationIndex = widget.indexChoosen;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ///List of body
    List<Widget> bodyList = const [
      BerandaScreen(),
      RiwayatPenyewaanScreen(),
      PengaturanScreen(),
    ];

    ///List of AppBar
    List<PreferredSizeWidget> appBarList = [
      berandaAppBar,
      riwayatPenyewaanAppBar,
      pengaturanAppBar,
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
    
        ///AppBar
        appBar: appBarList[navigationIndex],
    
        ///Body
        body: bodyList[navigationIndex],
    
        ///BotNavBar
        bottomNavigationBar: Container(
          color: primaryLightColor,
          height: 89,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BottomNavigationBar(
              selectedFontSize: 16,
              unselectedFontSize: 16,
              backgroundColor: primaryLightColor,
              selectedItemColor: infoColor,
              unselectedItemColor: primaryLightestColor,
              currentIndex: navigationIndex,
              elevation: 0,
              onTap: (index){
                navigationIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icon/Home.svg', 
                    // ignore: deprecated_member_use
                    color: (navigationIndex == 0) ? infoColor : primaryLightestColor,
                  ),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icon/File-Text.svg',
                    // ignore: deprecated_member_use
                    color: (navigationIndex == 1) ? infoColor : primaryLightestColor,
                  ),
                  label: 'Riwayat'
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icon/Settings.svg',
                    // ignore: deprecated_member_use
                    color: (navigationIndex == 2) ? infoColor : primaryLightestColor,
                  ),
                  label: 'Pengaturan'
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}