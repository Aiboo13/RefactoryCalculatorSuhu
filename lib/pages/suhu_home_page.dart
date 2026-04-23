import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_minggu_3_konvensi_suhu/bloc/suhu_bloc.dart';

class SuhuHomePage extends StatefulWidget {
  const SuhuHomePage({super.key});

  @override
  State<SuhuHomePage> createState() => _SuhuHomePageState();
}

class _SuhuHomePageState extends State<SuhuHomePage> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Suhu')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SuhuBloc, SuhuState>(
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _inputController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Nilai Suhu',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    context.read<SuhuBloc>().add(SuhuInputChanged(value));
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDropdown(state.fromUnit, (val) {
                      if (val == null) return;
                      context.read<SuhuBloc>().add(SuhuFromUnitChanged(val));
                    }),
                    const Icon(Icons.arrow_forward),
                    _buildDropdown(state.toUnit, (val) {
                      if (val == null) return;
                      context.read<SuhuBloc>().add(SuhuToUnitChanged(val));
                    }),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    context.read<SuhuBloc>().add(SuhuCalculatePressed());
                  },
                  child: const Text('HITUNG'),
                ),
                const SizedBox(height: 30),
                Text(
                  'Hasil: ${state.result.toStringAsFixed(2)} ${state.toUnit}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: value,
      items: suhuUnits
          .map((u) => DropdownMenuItem(value: u, child: Text(u)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
