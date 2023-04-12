import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/pilih_waktu.dart';

class PilihJadwalScreen extends StatelessWidget {
  const PilihJadwalScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              PilihWaktu(),
            ],
          ),
        )
      ),
    );
  }
}