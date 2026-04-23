import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_minggu_3_konvensi_suhu/bloc/suhu_bloc.dart';
import 'package:tugas_minggu_3_konvensi_suhu/pages/suhu_home_page.dart';

void main() => runApp(const KonversiSuhuApp());

class KonversiSuhuApp extends StatelessWidget {
  const KonversiSuhuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuhuBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SuhuHomePage(),
      ),
    );
  }
}
