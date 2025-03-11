import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../design_system/components/input.dart';
import 'components/home_card.dart';
import 'components/home_chip.dart';
import 'utils/home_chip.dart';

class HomePresentation extends StatefulWidget {
  const HomePresentation({super.key});

  @override
  State<HomePresentation> createState() => _HomePresentationState();
}

class _HomePresentationState extends State<HomePresentation> {
  final HomeViewModel viewModel = inject<HomeViewModel>();

  @override
  void initState() {
    viewModel.loadApod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<bool>(
            stream: viewModel.loading,
            initialData: false,
            builder: (context, snapshot) {
              final bool isLoading = snapshot.data!;
              if (isLoading) {
                return const CircularProgressIndicator();
              }

              return ListView(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Olá, Eclipse!'),
                      CircleAvatar(
                        child: Text('E'),
                      ),
                    ],
                  ),
                  Text(
                    'Bom dia',
                    style: GoogleFonts.playfair(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      print('ralou');
                    },
                    child: const AbsorbPointer(child: AppInput()),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: HomeChip.chips().length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) =>
                          HomeChipComponent(
                        chipDetail: HomeChip.chips()[index],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Últimos favoritos',
                    style: GoogleFonts.playfair(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 18),
                          child: const HomeImageCard(
                            imageUrl:
                                'https://apod.nasa.gov/apod/image/2503/California_Mendez_960.jpg',
                            title: '',
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void openDatePicker(BuildContext context) => BottomPicker.date(
        pickerTitle: const Text(
          'Selecione uma data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.blue,
          ),
        ),
        dateOrder: DatePickerDateOrder.dmy,
        initialDateTime: DateTime(1996, 10, 22),
        maxDateTime: DateTime(1998),
        minDateTime: DateTime(1980),
        onChange: (index) {
          print(index);
        },
        onSubmit: (index) {
          print(index);
        },
        bottomPickerTheme: BottomPickerTheme.plumPlate,
      ).show(context);
}
