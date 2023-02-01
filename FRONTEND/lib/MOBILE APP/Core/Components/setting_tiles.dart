///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

InkWell settingTilesMA(
    {required BuildContext context,
    required VoidCallback? onTap,
    required String title,
    required String subtitle,
    required IconData icon}) {
  return InkWell(
    splashColor: primaryColour,
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : Colors.black38,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 8.0),
          child: Icon(
            icon,
            color: primaryColour,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          color: primaryColour,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Fira Sans',
            fontWeight: FontWeight.bold,
            // fontFamily: 'Ninto',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Fira Sans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}

InkWell settingListTilesMA(
    {required BuildContext context,
    required void Function(bool)? onChanged,
    required String title,
    required String subtitle,
    required bool value}) {
  return InkWell(
    splashColor: primaryColour,
    child: Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: DynamicTheme.of(context)?.brightness == Brightness.light
            ? Colors.white
            : Colors.black38,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: SwitchListTile(
        activeColor: primaryColour,
        //Theme.of(context).primaryColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Fira Sans',
              fontWeight: FontWeight.bold,
              // fontFamily: 'Ninto',
            ),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0, left: 8.0),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'Fira Sans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    ),
  );
}

InkWell settingTilesWS({
  required BuildContext context,
  required VoidCallback? onTap,
  required String title,
  required String subtitle,
  required IconData icon,
}) {
  return InkWell(
    splashColor: primaryColour,
    onTap: onTap,
    child: ListTile(
      trailing: Icon(
        icon,
        color: primaryColour,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Fira Sans',
          fontWeight: FontWeight.bold,
          // fontFamily: 'Ninto',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontFamily: 'Fira Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

InkWell settingListTilesWS(
    {required BuildContext context,
    required void Function(bool)? onChanged,
    required String title,
    required String subtitle,
    required bool value}) {
  return InkWell(
    splashColor: primaryColour,
    child: SwitchListTile(
      activeColor: primaryColour,
      //Theme.of(context).primaryColor,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Fira Sans',
          fontWeight: FontWeight.bold,
          // fontFamily: 'Ninto',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontFamily: 'Fira Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
      value: value,
      onChanged: onChanged,
    ),
  );
}
