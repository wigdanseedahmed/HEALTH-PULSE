///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class FilterChipListWidget extends StatelessWidget {
  const FilterChipListWidget({
    Key? key,
    required this.onSelected,
    required this.list,
    required this.isSelected,
  }) : super(key: key);

  final List list;
  final List isSelected;
  final Function(int index, bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      color: DynamicTheme.of(context)?.brightness == Brightness.light
          ? Colors.white
          : Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: List.generate(
            list.length,
                (index) => Container(
              margin: const EdgeInsets.only(right: 10),
              child: FilterChip(
                labelStyle: TextStyle(
                    color: isSelected[index] ? kWhiteColor : kBlackColor),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(list[index]),
                ),
                selectedColor: kShamrock,
                backgroundColor:
                isSelected[index] ? kGreenColor : DynamicTheme.of(context)?.brightness == Brightness.light
                    ? Colors.grey.shade300
                    : Colors.white54,
                onSelected: (value) {
                  onSelected(index, value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterChipListWidget2 extends StatelessWidget {
  const FilterChipListWidget2({
    Key? key,
    required this.onSelected,
    required this.list,
  }) : super(key: key);

  final List list;
  final Function(int index, bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: List.generate(
          list.length,
              (index) => Container(
            margin: const EdgeInsets.only(right: 10),
            child: FilterChip(
              labelStyle: TextStyle(
                  color: list[index]['isSelected'] ? kWhiteColor : kBlackColor),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(list[index]['text']),
              ),
              selectedColor: kGreenColor,
              backgroundColor: list[index]['isSelected']
                  ? kGreenColor
                  : Colors.grey.shade300,
              onSelected: (value) {
                onSelected(index, value);
              },
            ),
          ),
        ),
      ),
    );
  }
}