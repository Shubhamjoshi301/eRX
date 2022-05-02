import 'package:erx/models/onboard_page_model.dart';
import 'package:erx/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({
    Key? key,
    required this.data,
    this.onButtonClick,
  }) : super(key: key);
  final OnBoardPageModel data;
  final VoidCallback? onButtonClick;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Center(
            child: SizedBox(
              height: 300,
              child: data.isLottie
                  ? Lottie.asset(data.image)
                  : SvgPicture.string(data.image),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  data.title,
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    color: ColorPalette.honeyDew,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
