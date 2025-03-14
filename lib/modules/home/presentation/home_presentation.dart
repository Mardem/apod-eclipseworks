import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:rxdart/rxdart.dart';

import '../../../design_system/components/input.dart';
import '../../favorites/vm/favorites_viewmodel.dart';
import '../data/models/remote/enums/apod_media_type.dart';
import '../data/models/remote/enums/apod_reaction.dart';
import '../data/models/remote/mapper/apod_mapper.dart';
import 'components/home_appbar.dart';
import 'components/home_banner.dart';
import 'components/home_card.dart';
import 'components/home_chip.dart';
import 'components/home_favorite_video_card.dart';
import 'components/home_video_banner.dart';
import 'shimmer/home_banner_shimmer.dart';
import 'utils/home_chip.dart';
import 'utils/home_chip_model.dart';

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
            return SafeArea(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffb3cbff).withOpacity(.4),
                          offset: const Offset(0, 2),
                          blurRadius: 9,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const HomeAppBar(),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _openDatePicker(),
                          child: const AbsorbPointer(
                            child: AppInput(
                              hintText: 'Selecione uma data',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'APOD de Hoje',
                      style: GoogleFonts.playfair(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(1, 1, 1, 1),
                      ),
                    ),
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

                      if (banner.mediaType == ApodMediaType.video) {
                        return HomeVideoBanner(
                          details: banner,
                        );
                      }

                      return HomeBanner(
                        details: banner,
                        viewModel: viewModel,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Últimos favoritos',
                      style: GoogleFonts.playfair(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: StreamBuilder<ApodReaction>(
                      stream: favoritesViewmodel.favoriteFilter,
                      builder: (context, snapshot) {
                        return Container(
                          height: 40,
                          margin: const EdgeInsets.only(top: 8),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: HomeChip.chips().length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              final chip = HomeChip.chips()[index];

                              return HomeChipComponent(
                                chipDetail: chip,
                                active: snapshot.data == chip.type,
                                onTapCallback: (HomeChipModel item) async =>
                                    favoritesViewmodel.filterFavoritesChip(
                                  chip: item,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: StreamBuilder<List<ApodModel>>(
                      stream: favoritesViewmodel.apod,
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Column(
                              children: [
                                Icon(LucideIcons.frown),
                                Text('Nenhum favorito por aqui...'),
                              ],
                            ),
                          );
                        }

                        return SizedBox(
                          height: 310,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final ApodModel details = snapshot.data![index];

                              return Container(
                                margin: const EdgeInsets.only(right: 18),
                                child: details.mediaType == ApodMediaType.image
                                    ? HomeImageCard(details: details)
                                    : HomeFavoriteVideoCard(details: details),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
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
