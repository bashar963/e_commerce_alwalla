import 'package:e_commerce_alwalla/screen/loyalty/loyalty_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoyaltyScreen extends StatefulWidget {
  @override
  _LoyaltyScreenState createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  final _loyaltyBloc = LoyaltyBloc();

  List<Reward> _rewards = [
    Reward("1", "VIP 0", "<1000 pts", "No reward", isSelected: true),
    Reward("2", "VIP 1", "<3000 pts", "150 LE"),
    Reward("3", "VIP 2", "<10000 pts", "500 LE"),
    Reward("4", "VIP 3", "<20000 pts", "1200 LE"),
    Reward("5", "VIP 4", "<50000 pts", "2000 LE"),
    Reward("6", "VIP 5", "<100000 pts", "4000 LE"),
    Reward("7", "Master", ">100000 pts", "6000 LE"),
  ];
  @override
  void dispose() {
    _loyaltyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text("Loyalty Program"),
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _loyaltyBloc;
        },
        child: BlocListener(
          cubit: _loyaltyBloc,
          listener: (c, LoyaltyState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _loyaltyBloc,
              builder: (c, LoyaltyState state) {
                return GestureDetector(
                    onTap: () {
                      hideKeyboard(context);
                    },
                    child: body(c));
              }),
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/bg.png"), fit: BoxFit.fill)),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/wallaa_2.svg",
                  width: 90,
                ),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Text.rich(TextSpan(
                        text: "399",
                        style: mainTextStyle.copyWith(
                            fontSize: 46, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                              text: " pts",
                              style: mainTextStyle.copyWith(
                                  fontSize: 22, fontWeight: FontWeight.w400))
                        ]))),
                const SizedBox(
                  width: 2,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Divider(),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Level",
                textAlign: TextAlign.center,
                style: mainTextStyle,
              ),
            ),
            Expanded(
              child: Text(
                "Points",
                textAlign: TextAlign.center,
                style: mainTextStyle,
              ),
            ),
            Expanded(
              child: Text(
                "Reward",
                textAlign: TextAlign.center,
                style: mainTextStyle,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 1,
          color: Color(0xFfF0F0F0),
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (c, i) => rewardItem(_rewards[i]),
          itemCount: _rewards.length,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
        ))
      ],
    );
  }

  Widget rewardItem(Reward reward) {
    return Column(
      children: [
        Container(
          height: 50,
          color: reward.isSelected ? redColor.withOpacity(0.1) : whiteColor,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  reward.level,
                  textAlign: TextAlign.center,
                  style: mainTextStyle.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  reward.points,
                  textAlign: TextAlign.center,
                  style: mainTextStyle.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                child: Text(
                  reward.reward,
                  textAlign: TextAlign.center,
                  style: mainTextStyle.copyWith(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 1,
          color: Color(0xFfF0F0F0),
        ),
      ],
    );
  }
}

class Reward {
  final String id, level, points, reward;
  bool isSelected;

  Reward(this.id, this.level, this.points, this.reward,
      {this.isSelected = false});
}
