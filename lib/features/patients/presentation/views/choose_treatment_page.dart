import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseTreatmentView extends StatefulWidget {
  const ChooseTreatmentView({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  State<ChooseTreatmentView> createState() => _ChooseTreatmentViewState();
}

class _ChooseTreatmentViewState extends State<ChooseTreatmentView> {
  final _controller = PageController();

  static const _pagePerItem = 6;
  late int _pageCount;
  late int _lastPageItemLength;
  int _selectedIndex = 0;

  static const aspectRatio = 99 / 91;
  static const gridCount = 3;
  static const horizontalSpace = 25.0;

  static const normalStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColor.textColor,
  );

  static const selectStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: AppColor.primaryColor,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<TreatmentCubit, TreatmentState>(
        builder: (context, state) {
          final num = state.suggestedTreatments.length / _pagePerItem;
          _pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

          final reminder =
              state.suggestedTreatments.length.remainder(_pagePerItem);
          _lastPageItemLength = reminder == 0 ? _pagePerItem : reminder;

          final totalGridHeight =
              (MediaQuery.of(context).size.width - horizontalSpace * 2) /
                  aspectRatio /
                  gridCount *
                  2;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search or add your own treatment',
                    hintStyle: AppFontStyle.hintStyle,
                  ),
                  textCapitalization: TextCapitalization.words,
                  style: AppFontStyle.textStyle,
                  onChanged: context.read<TreatmentCubit>().onTreatmentChanged,
                  // autofocus: true,
                ),
              ),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Suggested Treatments',
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              const SizedBox(height: 23),
              SizedBox(
                height: totalGridHeight,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pageCount,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  itemBuilder: (_, pIndex) => GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCount,
                      childAspectRatio: aspectRatio,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: horizontalSpace),
                    children: List.generate(
                      (_pageCount - 1) != pIndex
                          ? _pagePerItem
                          : _lastPageItemLength,
                      (index) {
                        final suggestedTreatment = state.suggestedTreatments[
                            index + (pIndex * _pagePerItem)];

                        return InkWell(
                          onTap: () =>
                              context.read<TreatmentCubit>().selectTreatment(
                                    suggestedTreatment.name,
                                  ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 4,
                                )
                              ],
                              border: Border.all(
                                color: suggestedTreatment.selected
                                    ? AppColor.primaryColor
                                    : const Color.fromRGBO(198, 198, 198, 0.5),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/treatments/${suggestedTreatment.name}.svg',
                                  color: suggestedTreatment.selected
                                      ? AppColor.primaryColor
                                      : null,
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    suggestedTreatment.name,
                                    textAlign: TextAlign.center,
                                    style: suggestedTreatment.selected
                                        ? selectStyle
                                        : normalStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 8,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _pageCount,
                    itemBuilder: (_, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.black
                              .withOpacity(_selectedIndex == index ? 1 : 0.3),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AppPrimaryButton(
                  title: 'Next',
                  onPressed: widget.onPressed,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}
