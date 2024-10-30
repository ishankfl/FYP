import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoarding extends StatelessWidget {
  List<Map> onboardingList = [
    {
      "image_path": "onboardingfirst.png",
      "txt": "Book Home Services Easily",
      "desc": "Book Home Services Easily",
    },
    {
      "image_path": "onboardingsecond.png",
      "txt": "Best Service Providers",
      "desc": "Best Service Providers",
    },
  ];

  OnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    // mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 27, vertical: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    BlocBuilder<IndexCubit, IndexState>(
                        builder: (context, state) {
                      return Column(children: [
                        Image.asset(
                            'assets/onboarding/${onboardingList[state.index]['image_path']}',
                            bundle: DefaultAssetBundle.of(context)),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                onboardingList[state.index]['txt'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),

                                // style: CustomTextStyles.titleLargeBlack90002
                                //     .copyWith(height: 1.31))),
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }),
                    const SizedBox(height: 98),
                    CustomElevatedButton(
                        height: 57,
                        width: 157,
                        text: "Next ",
                        onPressed: () {
                          context.read<IndexCubit>().increment(context);
                          // onTapNext(context);
                        },
                        alignment: Alignment.center),
                    const SizedBox(height: 20),
                    // Text()}'),
                    const Spacer(),
                    BlocBuilder<IndexCubit, IndexState>(
                        builder: (context, state) {
                      return Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 11,
                            child: AnimatedSmoothIndicator(
                              activeIndex: state.index,
                              count: 2,
                              effect: const JumpingDotEffect(
                                  dotColor: Color.fromARGB(255, 238, 237, 237),
                                  activeDotColor: Color.fromRGBO(9, 54, 96, 1),
                                  spacing: 1.5,
                                  dotHeight: 10),
                            )),
                      );
                    })
                  ],
                ))));
  }
}
