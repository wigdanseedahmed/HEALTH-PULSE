///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:locations_repository/locations_repository.dart'
    hide HealthFacilityInformationModel;

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSelected,
  });

  final void Function(HealthFacilityInformationModel) onSelected;

  static const _inputBorderRadius = 25.0;
  static const _mainMargin = 12.0;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    final locationInputService = LocationInputService(
        // locationsRepository: context.read<LocationsRepository>(),
        );
    return StatefulBuilder(builder: (context1, setStateD) {
        return Autocomplete<HealthFacilityInformationModel>(
          displayStringForOption: (option) => option.address!,
          optionsBuilder: (textEditingValue) async {
            final options = await locationInputService.getSuggestionsFromFile(
              textEditingValue.text,
            );
            return options;
          },
          fieldViewBuilder: _textField,
          onSelected: widget.onSelected,
          optionsViewBuilder: _optionsViewBuilder,
        );
      }
    );
  }

  ///------------------------- SEARCH BAR -------------------------///
  Widget _textField(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    void Function() onFieldSubmitted,
  ) {
    final l10n = context.l10n;

    return StatefulBuilder(builder: (context1, setStateD) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: LocationInput._mainMargin,
        ),
        child: Listener(
          onPointerUp: (event) {
            textEditingController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onPointerDown: (event) {
            textEditingController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onPointerCancel: (event) {
            textEditingController.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: TextField(
            controller: textEditingController,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black.withOpacity(0.55),
              contentPadding: const EdgeInsets.all(15),
              prefixIcon: const IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    textEditingController.clear();
                  });
                  setStateD(() {
                    textEditingController.clear();
                  });
                },
              ),
              hintText: l10n.findLocation,
              hintStyle: Theme.of(context).textTheme.headline5,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  LocationInput._inputBorderRadius,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  LocationInput._inputBorderRadius,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  ///------------------------- SEARCH RESULTS -------------------------///
  Widget _optionsViewBuilder(
    BuildContext context,
    void Function(HealthFacilityInformationModel) onSelected,
    Iterable<HealthFacilityInformationModel> options,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    const itemHeight = 100.0;

    final listHeight = 0.5 * screenHeight ~/ itemHeight * itemHeight;

    return StatefulBuilder(
      builder: (context1, setStateD) {
        return options == null || options.isEmpty
            ? Container()
            : Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: LocationInput._inputBorderRadius +
                      LocationInput._mainMargin,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: Colors.transparent,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: listHeight),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final option = options.elementAt(index);

                          return Container(
                            decoration: BoxDecoration(
                              color: DynamicTheme.of(context)?.brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.white30,
                              borderRadius: BorderRadius.circular(0.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1.0,
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            height: itemHeight,
                            child: Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        onSelected(option);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      });
                                      setStateD(() {
                                        onSelected(option);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      });
                                    },
                                    child: ListTile(
                                      minVerticalPadding: 0,
                                      title: Text(
                                        option.medical_facility_name_en == null
                                            ? option.medical_facility_name_ar ==
                                                    null
                                                ? option.doctor_name == null
                                                    ? ""
                                                    : option.doctor_name!
                                                : option
                                                    .medical_facility_name_ar!
                                            : option.medical_facility_name_en!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      subtitle: Text(
                                        option.address == null
                                            ? ""
                                            : option.address!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(height: 3),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
