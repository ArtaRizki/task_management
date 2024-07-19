// import 'package:task_management/helper/currencies.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:task_management/common/helper/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:task_management/helper/constant.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

// import '../main.dart';
// import '../themes.dart';

class Widgets {
  static PreferredSizeWidget AppBar2(
      {String? title,
      List<Widget>? actions,
      PreferredSize? bottomWidget,
      Color? color,
      Color titleColor = Colors.white,
      Brightness brightness = Brightness.light}) {
    return AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(color: titleColor),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      leading: InkWell(
        onTap: null,
        child: Container(
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12, spreadRadius: .7, blurRadius: 1)
              ]),
          alignment: Alignment.center,
          child: const Icon(
            Icons.chevron_left,
            size: 24,
          ),
        ),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: color,
      bottom: bottomWidget,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: color, statusBarIconBrightness: brightness),
    );
  }

  static PreferredSizeWidget xAppBar(String title,
      {PreferredSizeWidget? bottom,
      TextStyle? titleStyle,
      Color backgroundColor = Colors.white,
      Color? iconColor = Colors.white,
      bool centerTitle = true,
      List<Widget>? actions,
      Widget? leading,
      Widget? titleWidget,
      bool automaticallyImplyLeading = true,
      double? elevation,
      SystemUiOverlayStyle? systemUiOverlayStyle}) {
    return AppBar(
      key: UniqueKey(),
      title: titleWidget ??
          Text(
            title,
            style: titleStyle,
          ),
      bottom: bottom,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(color: iconColor),
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      elevation: elevation ?? 0,
      systemOverlayStyle: systemUiOverlayStyle,
    );
  }

  static Widget loadingCircular(
      {double? size,
      double strokeWidth = 4.0,
      Color color = const Color(0xFF1039AA)}) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }

  static notFound(
    VoidCallback callBack, {
    String label = 'Muat Ulang',
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Constant.xSizedBox12,
          Text(
            "Maaf, Data kosong.",
            // style: TextStyles.bold.copyWith(
            //   fontSize: 16,
            // ),
          ),
          Constant.xSizedBox12,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                80,
                44,
              ),
            ),
            onPressed: callBack,
            child: Text(label),
          ),
        ],
      ),
    );
  }

  static haveError(VoidCallback callBack) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/img-error.png",
            width: 250,
          ),
          Constant.xSizedBox12,
          Text(
            "Maaf, Telah terjadi galat!",
            // style: TextStyles.bold.copyWith(
            //   fontSize: 18,
            // ),
          ),
          Constant.xSizedBox12,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                80,
                44,
              ),
            ),
            onPressed: callBack,
            child: const Text("Muat Ulang"),
          ),
        ],
      ),
    );
  }

  static showError(BuildContext context, VoidCallback callBack) async {
    return await showModalBottom(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/img-error.png",
            width: 250,
          ),
          Constant.xSizedBox12,
          Text(
            "Maaf, Telah terjadi galat!",
            // style: TextStyles.bold.copyWith(
            //   fontSize: 18,
            // ),
          ),
          Constant.xSizedBox12,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(
                80,
                44,
              ),
            ),
            onPressed: callBack,
            child: const Text("Muat Ulang"),
          ),
        ],
      ),
    );
  }

  static Widget lostConnection() {
    return Container();
  }

  static Widget showEmpty() {
    return Container();
  }

  static Widget textFieldArea(
      {required String label,
      Key? key,
      String? initialValue,
      Function(String)? onChanged,
      TextEditingController? controller,
      InputDecoration? decoration,
      bool readOnly = false,
      VoidCallback? onTap,
      validator,
      Function(String?)? onSave,
      bool obscureText = false,
      Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(label),
        // xSizedBox8,
        TextFormField(
          key: key ?? (controller == null ? UniqueKey() : null),
          controller: controller,
          onSaved: onSave,
          decoration: decoration ??
              Constant.outlinedDecoration.copyWith(
                // constraints: BoxConstraints(
                //     maxHeight: 36
                // ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                hintText: label,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 0.5, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 0.5, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 0.5, color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.grey,
              ),
          onChanged: onChanged,
          initialValue: initialValue,
          readOnly: readOnly,
          maxLines: 6,
          validator: validator,
          onTap: onTap,
          keyboardType: TextInputType.multiline,
          obscureText: obscureText,
        )
      ],
    );
  }

  static Widget squareBtn(
    Widget icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        child: icon,
      ),
    );
  }

  static Widget dropDown(
      List<String> values, String dropdownValue, Function(String?) getNewValue,
      {Function(String?)? onSaved, String? Function(String?)? validator}) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: dropdownValue,
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration(
              hintText: '',
              isCollapsed: true,
              contentPadding:
                  Constant.xVEdgeInsets12.add(Constant.xHEdgeInsets12),
              fillColor: const Color(0xfffafafa),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide:
                      BorderSide(color: Constant.primaryColor, width: 0.5)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide:
                      const BorderSide(color: Colors.grey, width: 0.5))),
          icon: const Icon(
            Icons.arrow_drop_down_outlined,
          ),
          elevation: 16,
          style: const TextStyle(
            color: Colors.black,
          ),
          onChanged: (String? newValue) {
            // setState(() {
            //   dropdownValue = newValue!;
            // });
            getNewValue(newValue);
          },
          items: values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  static void showSnackBar(
    BuildContext context,
    String text,
    bool isError, {
    SnackBarAction? action,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: (isError) ? Colors.red : Colors.green,
      margin: const EdgeInsets.all(22),
      action: action,
      duration: duration ?? const Duration(seconds: 2),
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );
    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget dropDownForm(
    List<String> values,
    String? dropdownValue, {
    Function(String?)? getNewValue,
    Color? color,
    bool enableBorder = false,
  }) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: Constant.xHEdgeInsets12,
        height: 44,
        decoration: BoxDecoration(
          color: color ?? Colors.grey,
          border:
              enableBorder ? Border.all(color: Colors.grey, width: 0.5) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          elevation: 16,
          style: const TextStyle(color: Colors.black87, fontSize: 13),
          onChanged: getNewValue,
          items: values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  static Future<bool> choiceDialog(
    BuildContext context,
    String title,
    String content, {
    bool reverseActionButton = false,
    String? positiveActionLabel,
    String? negativeActionLabel,
  }) async {
    List<Widget> actions(_) => [
          TextButton(
              onPressed: () {
                Navigator.pop(_, false);
              },
              child: Text(negativeActionLabel ?? "Tidak")),
          TextButton(
              onPressed: () {
                Navigator.pop(_, true);
              },
              child: Text(positiveActionLabel ?? "Ya")),
        ];

    return (await showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: (reverseActionButton)
                    ? actions(_).reversed.toList()
                    : actions(_),
              );
            })) ??
        false;
  }

  static divider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.black.withAlpha(12),
    );
  }

  static koin() {
    return Image.asset(
      'assets/icons/Koin.png',
      width: 24,
      height: 24,
    );
  }

  static koinAmountD(double? amount, {double fontSize = 14}) {
    return koinAmount(amount == null ? 'Gratis' : '${amount.floor()} Koin');
  }

  static koinAmount(String amount, {double fontSize = 14}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: amount.toLowerCase() != 'gratis',
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: Image.asset(
              'assets/icons/Koin.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
        Card(
          color: Constant.secondaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: Constant.xHEdgeInsets8
                .add(const EdgeInsets.symmetric(vertical: 2)),
            child: Text(
              amount,
              // style: TextStyles.bold
              //     .copyWith(color: Colors.white, fontSize: fontSize),
            ),
          ),
        )
      ],
    );
  }

  static sharpCard(Widget child,
      {Color color = const Color(0xFF1039AA),
      EdgeInsets margin = EdgeInsets.zero,
      double elevation = 0}) {
    return Card(
      margin: margin,
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: child,
    );
  }

  /// small card with Constant.primaryColorSoft
  static card2(String label,
      {EdgeInsetsGeometry? padding,
      bool active = false,
      double? width,
      double? height,
      int maxline = 1}) {
    return Container(
      width: width,
      height: height,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: active ? Constant.secondaryColor : Color(0xFF1039AA),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
              child: AutoSizeText(
                label,
                // style: TextStyles.medium.copyWith(
                //     color: active ? Colors.white : Constant.secondaryColor),
                maxLines: maxline,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  static outlinedMainButton(String label,
      {Size? minimumSize,
      required VoidCallback onPressed,
      bool active = false,
      double fontSize = 14,
      TextAlign textAlign = TextAlign.center}) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        label,
        // style: TextStyles.bold.copyWith(
        //   color: active ? Colors.white : Constant.secondaryColor,
        // ),
        textAlign: textAlign,
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: active ? Constant.secondaryColor : Colors.white,
        fixedSize: const Size(double.infinity, 32),
        minimumSize: minimumSize,
        // textStyle: TextStyles.bold.copyWith(
        //     color: active ? Colors.white : Constant.secondaryColor,
        //     fontSize: fontSize)
      ),
    );
  }

  static backButton({VoidCallback? onPressed}) {
    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          return;
        }
        // mainRouter.pop();
      },
      icon: const Icon(
        Icons.chevron_left,
        size: 32,
      ),
    );
  }

  static flyer(
      {Widget? child,
      DecorationImage? backgroundImage,
      Color? background,
      EdgeInsetsGeometry? margin,
      double width = double.infinity,
      double height = 380}) {
    return Container(
      width: width,
      height: height,
      constraints: const BoxConstraints(maxHeight: 320),
      margin: margin ?? const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(28),
          image: backgroundImage,
          boxShadow: [
            const BoxShadow(
              color: Colors.black54,
              blurRadius: 1,
            ),
          ]),
      child: child,
    );
  }

  static flyerStack(
      {List<Widget>? children,
      DecorationImage? backgroundImage,
      Color? background,
      EdgeInsetsGeometry? margin,
      required VoidCallback onClick}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 380),
        margin: margin ?? const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(28),
            image: backgroundImage,
            boxShadow: [
              const BoxShadow(
                color: Colors.black54,
                blurRadius: 1,
              ),
            ]),
        child: Stack(
          children: children ?? [],
        ),
      ),
    );
  }

  static bigCardGradientBottom({Widget? child, double? height}) {
    return Container(
      height: height ?? 132,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white70,
                Colors.white10,
                Colors.transparent,
                Colors.transparent,
              ]),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28))),
      child: child,
    );
  }

  static cardDate(DateTime date) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        width: 72,
        height: 72,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '20',
              // style: TextStyles.bold.copyWith(fontSize: 20),
            ),
            const AutoSizeText(
              'Januari',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }

  static smImage(String s) {
    return Image.asset(
      s,
      width: 24,
      height: 24,
    );
  }

  static networkImage(String url,
      {double? width,
      double? height,
      BoxFit? fit,
      ImageErrorWidgetBuilder? errorBuilder}) {
    return Image.network(
      url,
      loadingBuilder: (_, __, ___) {
        if (___ != null &&
            ___.expectedTotalBytes != null &&
            ___.cumulativeBytesLoaded >= ___.expectedTotalBytes!) {
          return Container(
            alignment: Alignment.center,
            child: loadingCircular(size: 32),
          );
        } else {
          return __;
        }
      },
      fit: fit,
      width: width,
      height: height,
      errorBuilder: errorBuilder,
    );
  }

  static radio<T>(
      {required String label,
      required Function(dynamic value) onChanged,
      required T value,
      T? groupValue}) {
    return Row(
      children: [
        Radio<T>(
          onChanged: onChanged,
          value: value,
          groupValue: groupValue,
        ),
        Text(label)
      ],
    );
  }

  static rating(double rate) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Text(rate.toString())
      ],
    );
  }

  static showModalBottom(BuildContext context,
      {required Widget child, bool withoutLine = false}) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: Constant.xVEdgeInsets12.add(Constant.xHEdgeInsets12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: !withoutLine,
                  child: Container(
                    width: 55,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
                Constant.xSizedBox18,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [child],
                ),
                Constant.xSizedBox18,
              ],
            ),
          );
        });
      },
    );
  }

  static draggableSheet(BuildContext context,
      {required Widget child,
      required DraggableScrollableController? controller,
      bool withoutLine = true}) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
              controller: controller,
              initialChildSize: 0.9,
              minChildSize: 0.1,
              maxChildSize: 0.96,
              expand: false,
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  padding: Constant.xVEdgeInsets8.add(Constant.xHEdgeInsets12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: child,
                );
              });
        });
      },
    );
  }

  // DateTime

  static Future<DateTime?> pickDate(
    BuildContext context,
    DateTime? date, {
    DatePickerMode? datePickerMode,
    DatePickerEntryMode? datePickerEntryMode,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      initialDatePickerMode: datePickerMode ?? DatePickerMode.day,
      initialEntryMode: datePickerEntryMode ?? DatePickerEntryMode.calendar,
      firstDate: firstDate ?? DateTime(2019),
      lastDate: lastDate ?? DateTime(2101),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Constant.primaryColor,
            colorScheme: ColorScheme.light(
              primary: Constant.primaryColor,
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != date) return picked;
    return null;
  }

  static Future<DateTimeRange?> pickDateRange(
    BuildContext context,
  ) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Constant.primaryColor,
            colorScheme: ColorScheme.light(primary: Constant.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) return picked;
    return null;
  }

  static Future<TimeOfDay?> pickTime(BuildContext context) async {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
  }

  /// Image Picker

  static Future<XFile?> takeCamera() async {
    XFile? f = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 480,
      maxHeight: 480,
      imageQuality: 75,
      preferredCameraDevice: CameraDevice.rear,
    );
    return f;
  }

  static Future<XFile?> selectImageFromGallery() async {
    XFile? f = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 75,
    );
    return f;
  }

  static avatar(String url, {double radius = 42}) {
    bool error = false;
    return StatefulBuilder(builder: (context, setState) {
      if (error) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: Colors.black12,
          foregroundImage: const AssetImage('assets/icons/icon-user.png'),
        );
      } else {
        return CircleAvatar(
            radius: radius,
            foregroundImage: CachedNetworkImageProvider(
              url,
              errorListener: (a) {
                setState(() {
                  error = true;
                });
              },
            ));
      }
    });
  }

  static Widget infoBox(String message, VoidCallback onClosed) {
    return Container(
      margin: Constant.xHEdgeInsets12,
      child: Stack(
        children: [
          Container(
            decoration:
                Constant.containerDecoration.copyWith(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(message),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: onClosed,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.close,
                  color: Constant.primaryColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget widgetOn, widgetOff;

  const ConditionalWidget(this.condition, this.widgetOn, this.widgetOff);

  @override
  Widget build(BuildContext context) {
    return (condition) ? widgetOn : widgetOff;
  }
}

class ConditionalWidget2 extends StatelessWidget {
  final bool condition;
  final Widget Function() widgetOn, widgetOff;

  const ConditionalWidget2(
      {required this.condition,
      required this.widgetOn,
      required this.widgetOff});

  @override
  Widget build(BuildContext context) {
    return (condition) ? widgetOn() : widgetOff();
  }
}

Future<void> Toast(String message) async {
  await EasyLoading.showToast(
    message,
    toastPosition: EasyLoadingToastPosition.bottom,
  );
}

Future Loading({bool show = true}) async {
  EasyLoading.instance
    // ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    // ..maskType = EasyLoadingMaskType.custom
    // ..maskColor = Colors.white
    //   ..indicatorcolor = const Color(0xFF1039AA);
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.black
    ..progressColor = Colors.white
    ..indicatorSize = 42
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.squareCircle
    ..backgroundColor = Colors.white
    ..dismissOnTap = true
    ..indicatorColor = Color(0xFF1039AA);

  if (!show) {
    return await EasyLoading.dismiss(animation: true);
  } else {
    return await EasyLoading.show();
  }
}

Future WrapLoading(Future future) async {
  await Loading();
  dynamic x;
  try {
    x = await future;
  } catch (e) {
    await Loading(show: false);
    rethrow;
  }
  await Loading(show: false);
  return x;
}

Future<T> WrapLoading2<T>(Future<T> future) async {
  await Loading();
  dynamic x;
  try {
    x = await future;
  } catch (e) {
    await Loading(show: false);
    rethrow;
  }
  await Loading(show: false);
  return x;
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
