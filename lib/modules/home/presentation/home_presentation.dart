import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../design_system/components/input.dart';
import '../data/models/remote/mapper/apod_mapper.dart';
import 'components/home_banner.dart';
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

  int _bottomNavIndex = 0;

  @override
  void initState() {
    viewModel.loadApod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          LucideIcons.house,
          LucideIcons.heart,
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
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
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _openDatePicker(),
                child: const AbsorbPointer(child: AppInput()),
              ),
              const SizedBox(height: 24),
              Text(
                'APOD de Hoje',
                style: GoogleFonts.playfair(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder<ApodModel>(
                stream: viewModel.apod,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<ApodModel> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  return HomeBanner(details: snapshot.data!);
                },
              ),
              const SizedBox(height: 24),
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
                height: 310,
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
          ),
        ),
      ),
    );
  }

  void _openDatePicker() => BottomPicker.date(
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
        maxDateTime: DateTime(DateTime.now().year),
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
