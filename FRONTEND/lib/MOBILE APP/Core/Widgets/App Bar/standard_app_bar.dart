///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

class StandardAppBar extends StatelessWidget with PreferredSizeWidget {
  const StandardAppBar({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: kBlueChill, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title!,
        style: const TextStyle(
            color: kBlueChill, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      /* flexibleSpace: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-1.0, 0.0),
            end: const Alignment(1.0, 0.0),
            colors: linearGradientColourScheme,
          ),
        ),
      ),*/
      // title: Text('Title'),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
