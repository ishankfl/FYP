import 'package:bookme/constant/colors.dart';
import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/common/app_bar.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory();

  @override
  Widget build(BuildContext context) {
    context
        .read<FetchPaymentBloc>()
        .add(FetchPaymentClickedEvent(token: getAccessToken(context)));

    return Scaffold(
      appBar: backBtnAppbar("Payment"),
      body: Container(
        color: ColorConstant.primary_color_dark(),
        child: SafeArea(
          child: Column(
            children: [
              TextFieldLabel(
                  colorr: Colors.white,
                  text: "Transaction History",
                  fontsize: 20,
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, left: 15)),
              BlocBuilder<FetchPaymentBloc, FetchPaymentState>(
                builder: (context, state) {
                  if (state is FetchPaymentLoaded) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          itemCount: state.model.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  height: 100,
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            "${ServerUrl.ipaddress()}${state.model[index].booking!.to!.user!.profile!}"),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.model[index].booking!.to!
                                                .user!.full_name!,
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .primary_color_dark(),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Total Amount: \ ${state.model[index].amount}',
                                            style: TextStyle(
                                              color: ColorConstant
                                                  .primary_color_dark(),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                  if (state is FetchPaymentError) {
                    return Text("eroor got");
                  }
                  if (state is FetchPaymentLoading) {
                    return CircularProgressIndicator();
                  }
                  context.read<FetchPaymentBloc>().add(
                      FetchPaymentClickedEvent(token: getAccessToken(context)));
                  return MaterialButton(
                    onPressed: () {
                      context.read<FetchPaymentBloc>().add(
                          FetchPaymentClickedEvent(
                              token: getAccessToken(context)));
                    },
                    child: Text("click here"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
