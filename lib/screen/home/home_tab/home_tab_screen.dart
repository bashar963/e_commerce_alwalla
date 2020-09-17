import 'package:e_commerce_alwalla/screen/home/home_tab/home_bloc.dart';
import 'package:e_commerce_alwalla/theme/app_theme.dart';
import 'package:e_commerce_alwalla/utils/common.dart';
import 'package:e_commerce_alwalla/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final _homeBloc = HomeBloc();

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return _homeBloc;
        },
        child: BlocListener(
          cubit: _homeBloc,
          listener: (c, HomeState state) async {
            if (state is Loading) {}
            if (state is Success) {}
            if (state is Failed) {
              showFailedMessage(context, state.error);
            }
          },
          child: BlocBuilder(
              cubit: _homeBloc,
              builder: (c, HomeState state) {
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
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SearchBar(
                textController: TextEditingController(), onComplete: () {}),
          ),
        ),
        space(24),
      ],
    );
  }

  space(double size) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size,
      ),
    );
  }
}
