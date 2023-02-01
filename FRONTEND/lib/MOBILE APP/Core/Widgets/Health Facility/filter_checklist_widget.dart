///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class FilterCheckListWidget extends StatelessWidget {
   FilterCheckListWidget({
    Key? key,
    required this.onSelected,
    required this.list,
    required this.selectedList,
    required this.isSelected,
    required this.height,
  }) : super(key: key);

  final double height;
  final List list;
   List selectedList;
  final List isSelected;
  final Function(int index) onSelected;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      height: list.length * screenSize.height * height,
      padding: const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 8),
      color: DynamicTheme.of(context)?.brightness == Brightness.light
          ? Colors.white
          : Colors.black12,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (BuildContext context1, int index) {
          return StatefulBuilder(builder: (context1, setStateD) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width * 0.75,
                    child: Text(
                      list[index],
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          onSelected(index);
                        },
                        icon: isSelected[index] == true
                            ? const Padding(
                                padding: EdgeInsets.only(right: 8, bottom: 22),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(right: 8, bottom: 28),
                                child: Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  color: Colors.red,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
