import 'package:eclipseworks_apod/main.dart';
import 'package:eclipseworks_apod/modules/home/home.dart';
import 'package:eclipseworks_apod/modules/home/presentation/components/image_view_component.dart';
import 'package:flutter/material.dart';

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
      body: StreamBuilder<bool>(
        stream: viewModel.loading,
        initialData: false,
        builder: (context, snapshot) {
          final bool isLoading = snapshot.data!;
          if (isLoading) {
            return CircularProgressIndicator();
          }

          return Column(
            children: [
              ImageViewComponent(viewModel: viewModel),
            ],
          );
        },
      ),
    );
  }
}
