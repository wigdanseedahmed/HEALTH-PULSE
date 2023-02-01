///---------------------------------------------- LIBRARIES ----------------------------------------------///

// ignore: import_of_legacy_library_into_null_safe

///----------------------------- 🎯 DART IMPORTS -----------------------------///

export 'dart:async';
export 'dart:convert';
export 'dart:core';
export 'dart:io'; //to convert json to maps and vice versa
export 'dart:math';
export 'dart:typed_data';

///----------------------------- 🐦 FLUTTER IMPORTS -----------------------------///

export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart';
export 'package:flutter/services.dart';
export 'package:flutter/widgets.dart';


///----------------------------- 📦 SYNCFUSIN PACKAGE IMPORTS -----------------------------///
export 'package:syncfusion_flutter_charts/charts.dart' hide Position;
export 'package:syncfusion_flutter_gauges/gauges.dart' hide CornerStyle;
export 'package:syncfusion_flutter_charts/sparkcharts.dart';
export 'package:syncfusion_flutter_maps/maps.dart';
export 'package:syncfusion_flutter_sliders/sliders.dart' hide LabelPlacement, LabelFormatterCallback, EdgeLabelPlacement;

///----------------------------- 📦 PACKAGE IMPORTS -----------------------------///

export 'package:animated_text_kit/animated_text_kit.dart';

export 'package:barcode_scan2/barcode_scan2.dart' hide AndroidOptions;

export 'package:cached_memory_image/cached_memory_image.dart';

export 'package:cached_network_image/cached_network_image.dart';

export 'package:carousel_slider/carousel_slider.dart';

export 'package:collapsible_sidebar/collapsible_sidebar.dart';

export 'package:country_icons/country_icons.dart';

export 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
export 'package:cupertino_date_textbox/cupertino_date_textbox.dart';

export 'package:custom_map_markers/custom_map_markers.dart';

export 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

export 'package:device_info/device_info.dart';

export 'package:dropdown_button2/dropdown_button2.dart';

export 'package:dropdown_search/dropdown_search.dart';

export 'package:email_validator/email_validator.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

export 'package:eva_icons_flutter/eva_icons_flutter.dart';

//export 'package:firebase_auth/firebase_auth.dart';
//export 'package:firebase_core/firebase_core.dart';

//export 'package:fluent_ui/fluent_ui.dart' hide  CheckboxTheme, CheckboxThemeData, Checkbox, ButtonThemeData, ButtonTheme, BottomSheet, showBottomSheet, BottomSheetThemeData, ButtonStyle, TextBox;

export 'package:flag/flag.dart';

export 'package:flutter_map/flutter_map.dart' hide PositionCallback, MapEvent;

export 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

export 'package:flutter_polyline_points/flutter_polyline_points.dart';

export 'package:flutter_portal/flutter_portal.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';

export 'package:flutter_secure_storage/flutter_secure_storage.dart';

export 'package:flutter_svg/flutter_svg.dart';

export 'package:font_awesome_flutter/font_awesome_flutter.dart';

export 'package:get_it/get_it.dart';

export 'package:get/get.dart' hide HeaderValue, Response, Transition;

export 'package:geolocator/geolocator.dart';

export 'package:google_fonts/google_fonts.dart';

export 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    show decodePolyline;

//export 'package:google_maps_flutter/google_maps_flutter.dart';

//export 'package:google_sign_in/google_sign_in.dart';

export 'package:http/http.dart' hide MultipartFile;

export 'package:image_gallery_saver/image_gallery_saver.dart';

export 'package:image_picker/image_picker.dart';

export 'package:intl/intl.dart' hide TextDirection;

export 'package:location/location.dart' hide Location, LocationAccuracy;

export 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

export 'package:flutter_slidable/flutter_slidable.dart'
    hide ConfirmDismissCallback;

export 'package:flutter_spinkit/flutter_spinkit.dart';

//export 'package:flutter_tags/flutter_tags.dart' hide OnChangedCallback,ItemTagsRemoveButton,ItemTags;

export 'package:json_store/json_store.dart';

export 'package:marker_icon/marker_icon.dart';

export 'package:material_floating_search_bar/material_floating_search_bar.dart';

export 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

export 'package:nb_utils/nb_utils.dart'
    hide GetDurationUtils, log, tan, StringExtension, ContextExtensions;

export 'package:omni_datetime_picker/omni_datetime_picker.dart';

export 'package:package_info/package_info.dart';

export 'package:percent_indicator/percent_indicator.dart' hide radians;

export 'package:permission_handler/permission_handler.dart' hide PermissionStatus, ServiceStatus;

export 'package:provider/provider.dart' hide ErrorBuilder;

//import 'package:search_widget/search_widget.dart';

export 'package:qr_flutter/qr_flutter.dart';

export 'package:responsive_framework/responsive_framework.dart' hide Condition;

export 'package:shared_preferences/shared_preferences.dart';

export 'package:sliding_up_panel/sliding_up_panel.dart';

export 'package:smooth_page_indicator/smooth_page_indicator.dart';

export 'package:table_calendar/table_calendar.dart';

export 'package:timeline_list/timeline.dart';
export 'package:timeline_list/timeline_model.dart';

export 'package:url_launcher/url_launcher.dart';

export 'package:webview_flutter/webview_flutter.dart';



///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
export 'package:health_pulse/locator.dart';

///---------------------------------------------- COMMON ----------------------------------------------///
export 'package:health_pulse/COMMON/import.dart';

///---------------------------------------------- MOBILE APP ----------------------------------------------///
export 'package:health_pulse/MOBILE APP/import.dart';

///---------------------------------------------- WEBSITE ----------------------------------------------///
export 'package:health_pulse/WEBSITE/import.dart';
