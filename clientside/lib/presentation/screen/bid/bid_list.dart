import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/logic/services/stringtodate.dart';
import 'package:bookme/presentation/screen/bid/bid_view.dart';
import 'package:bookme/presentation/screen/chat/chat_list.dart';
import 'package:bookme/presentation/screen/map/map_view_only.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/presentation/widget/photo_view_widget.dart';
import 'package:bookme/presentation/widget/show_mapview_dialog.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class BidList extends StatelessWidget {
  const BidList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageBottonAppBar("Bid"),
      body: Center(
        child: BlocBuilder<FetchBidListBloc, FetchBidListState>(
          builder: (context, state) {
            if (state is FetchBidListLoaded) {
              return ListView.builder(
                  itemCount: state.loginModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BidItemWidget(bid: state.loginModel[index]);
                  });
            }
            if (state is FetchBidListError) {
              return const Text("error");
            }
            if (state is FetchBidListLoading) {
              return const CircularProgressIndicator();
            }
            if (state is FetchBidListEmpty) {
              return ErrorFetchingData(
                message: "No Data",
                btnName: "Refresh",
                onPressed: () {
                  BlocProvider.of<FetchBidListBloc>(context).add(
                      FetchBidListClickedEvent(token: getAccessToken(context)));
                },
              );
            }
            context
                .read<FetchBidListBloc>()
                .add(FetchBidListClickedEvent(token: getAccessToken(context)));

            return const Placeholder();
          },
        ),
      ),
    );
  }
}

class BidItemWidget extends StatelessWidget {
  BidModel bid;

  BidItemWidget({super.key, required this.bid});
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = StringToDate(bid.timestamp!);

    return Card(
      margin: const EdgeInsets.all(15.0),
      child: ListTile(
        leading: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return PhotoViewPage(
                  url: ServerUrl.ipaddress() + bid.user!.profile.toString());
            }));
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                ServerUrl.ipaddress() + bid.user!.profile.toString()),
          ),
        ),
        title: TextFieldLabel(
            // ignore: unnecessary_string_interpolations
            text: "${bid.user!.full_name.toString()}",
            padding: const EdgeInsets.all(0),
            fontsize: 17),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldLabel(
                text: 'Service: ${bid.service!.service_name}',
                padding: const EdgeInsets.all(1)),
            TextFieldLabel(
                text_align: TextAlign.left,
                text:
                    'Date:  ${dateTime.year}/${dateTime.month}/${dateTime.day}  ${dateTime.hour}:${dateTime.day}',
                padding: const EdgeInsets.all(1)),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) {
                  return BidView(
                    model: bid,
                  );
                }));
              },
              child: const Text(
                "View More ...",
                style: TextStyle(color: Color.fromARGB(255, 120, 162, 235)),
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.location_on),
              onPressed: () {
                try {
                  context.read<ChoosePlaceCubit>().change(
                      LatLng(bid.lat!.toDouble(), bid.lon!.toDouble()), 15);
                  context.read<LocationCubit>().showAddressByPoint(
                      bid.lon!.toDouble(), bid.lat!.toDouble());
                } catch (e) {
                  context
                      .read<ChoosePlaceCubit>()
                      .change(const LatLng(0, 0), 15);
                  context.read<LocationCubit>().showAddressByPoint(0, 0);
                }
                showMapViewDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
// void showMapBox()