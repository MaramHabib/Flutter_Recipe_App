import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';
import '../utils/colors.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({super.key});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  late PageController pageController;
  // Added lines
  bool showBtns = false;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    initListener();
    // Added show btn function
    showBtnsFunc();
    super.initState();
  }
//code to make button wait for page builder
  void initListener() async {
    await Future.delayed(const Duration(milliseconds: 100));
    pageController.addListener(() {
      setState(() {});
    });
  }
// Added function
  void showBtnsFunc() async {
    await Future.delayed(const Duration(milliseconds: 120));
    showBtns = true;
    setState(() {});
  }

  ButtonStyle? buttonStyle(int index) {
    return (index == pageController.page?.toInt())
        ? TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(ColorsConst.mainColor))
        : null;
  }

  void onTapOnBtn(int index) async {
    await pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Added first line
            if (showBtns)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: buttonStyle(0),
                      onPressed: () => onTapOnBtn(0),
                      child: Text('first page')),
                  TextButton(
                      style: buttonStyle(1),
                      onPressed: () => onTapOnBtn(1),
                      child: Text('second page')),
                  TextButton(
                      style: buttonStyle(2),
                      onPressed: () => onTapOnBtn(2),
                      child: Text('third page')),
                ],
              ),
            Expanded(
              child: PageView(
                scrollDirection: Axis.vertical,
                // physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  // ***********************  Adding Bloc Consumer ********************
                  BlocConsumer<CounterCubit, CounterState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Text(state.counterValue.toString()),
                            ElevatedButton(
                                onPressed: () =>
                                    BlocProvider.of<CounterCubit>(context)
                                        .increment(),
                                child: Text('+')),
                            ElevatedButton(
                                onPressed: () =>
                                    BlocProvider.of<CounterCubit>(context)
                                        .decrement(),
                                child: Text('-'))
                          ],
                        );
                      },
                      listener: (_, __) {}),
                  // ***********************  End Bloc Consumer *******************
                  Container(
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.yellow,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}