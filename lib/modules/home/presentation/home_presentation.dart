import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../design_system/components/input.dart';
import '../../favorites/routes/favorites_routes.dart';
import '../../favorites/vm/favorites_viewmodel.dart';
import '../data/models/remote/mapper/apod_mapper.dart';
import 'components/home_banner.dart';
import 'components/home_card.dart';
import 'components/home_chip.dart';
import 'shimmer/home_banner_shimmer.dart';
import 'utils/home_chip.dart';

class HomePresentation extends StatefulWidget {
  const HomePresentation({super.key});

  @override
  State<HomePresentation> createState() => _HomePresentationState();
}

class _HomePresentationState extends State<HomePresentation> {
  final HomeViewModel viewModel = inject<HomeViewModel>();
  final FavoritesViewmodel favoritesViewmodel = inject<FavoritesViewmodel>();

  @override
  void initState() {
    viewModel.loadApod();
    favoritesViewmodel.loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: StreamBuilder<bool>(
          stream: viewModel.loading,
          builder: (BuildContext context, AsyncSnapshot<bool> loadingSnapshot) {
            final bool isLoading = loadingSnapshot.data ?? false;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Olá, Eclipse!'),
                        GestureDetector(
                          onTap: () {
                            router.navigateTo(
                              context,
                              FavoritesRoutesPath.favorites.path,
                            );
                          },
                          child: const CircleAvatar(
                            child: Text('E'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _openDatePicker(),
                      child: const AbsorbPointer(
                        child: AppInput(
                          hintText: 'Selecione uma data',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'APOD de Hoje',
                      style: GoogleFonts.playfair(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(1, 1, 1, 1)),
                    ),
                    StreamBuilder<List<dynamic>>(
                      stream: CombineLatestStream.list([
                        viewModel.loading,
                        viewModel.apod,
                      ]),
                      initialData: const [false, null],
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot,
                      ) {
                        final bool isLoading = snapshot.data?[0];
                        final ApodModel? banner = snapshot.data?[1];

                        if (banner == null || isLoading) {
                          return const HomeBannerShimmer();
                        }

                        return HomeBanner(
                          details: banner,
                          viewModel: viewModel,
                          onAddCallback: () async {
                            await favoritesViewmodel.loadFavorites();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Últimos favoritos',
                      style: GoogleFonts.playfair(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                    StreamBuilder<List<ApodModel>>(
                      stream: favoritesViewmodel.apod,
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return SizedBox(
                          height: 310,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 18),
                                child: HomeImageCard(
                                  details: snapshot.data![index],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openDatePicker() => BottomPicker.date(
        buttonContent: const Text('Selecionar'),
        buttonAlignment: MainAxisAlignment.center,
        buttonWidth: 88,
        buttonSingleColor: Colors.black.withOpacity(0.1),
        pickerTitle: const Text(
          'Selecione uma data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.blue,
          ),
        ),
        dateOrder: DatePickerDateOrder.dmy,
        initialDateTime: DateTime.now(),
        maxDateTime: DateTime.now(),
        minDateTime: DateTime(1990),
        onSubmit: (date) {
          final DateTime dateTime = date as DateTime;

          final format = DateFormat('y-M-dd');
          final dateString = format.format(dateTime);

          viewModel.loadApod(parameters: {'date': dateString});
        },
        bottomPickerTheme: BottomPickerTheme.plumPlate,
      ).show(context);
}
