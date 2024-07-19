import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomContainer {
  /// main card using container
  static Widget mainCard({
    required Widget child,
    bool isShadow = true,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? width,
    double? height,
    double? radiusBorder,
    DecorationImage? image,
  }) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.all(12),
      width: width ?? null,
      height: height ?? null,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        image: image,
        borderRadius: BorderRadius.circular(radiusBorder ?? 12),
        boxShadow: [
          if (isShadow)
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
        ],
      ),
      child: child,
    );
  }

  static Widget mainCardNoShadow({
    required Widget child,
    bool isShadow = false,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? width,
    double? height,
    double? radiusBorder,
  }) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.all(12),
      width: width ?? null,
      height: height ?? null,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(radiusBorder ?? 12),
        boxShadow: [
          if (isShadow)
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
        ],
      ),
      child: child,
    );
  }

  static Center mainNotFoundImage() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              "assets/images/main-image-not-found.png",
            ),
            width: 275,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Data tidak ditemukan!",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  static showModalBottom({
    required BuildContext context,
    required Widget child,
    double? initialChildSize,
    DraggableScrollableController? controller,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
            controller: controller ?? DraggableScrollableController(),
            initialChildSize: initialChildSize ?? 0.9,
            minChildSize: 0.1,
            maxChildSize: 0.96,
            expand: false,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.all(12),
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
                    Container(
                      width: 55,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [child],
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  static showModalBottomScroll({
    required BuildContext context,
    required Widget child,
    double? initialChildSize,
    DraggableScrollableController? controller,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: controller ?? DraggableScrollableController(),
          initialChildSize: initialChildSize ?? 0.9,
          minChildSize: 0.1,
          maxChildSize: 0.96,
          expand: false,
          snap: true,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(12),
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
                  Container(
                    width: 55,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  SizedBox(height: 18),
                  Expanded(child: ListView(children: [child])),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static showModalBottomScroll2({
    required BuildContext context,
    required Widget child,
    // double? initialChildSize,
    // DraggableScrollableController? controller,
    // VoidCallback? callback,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                12.0, 12.0, 12.0, MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Form(child: child),
          ),
        );
      },
    );
  }

  static Future<void> showModalBottomScrollFilter({
    required BuildContext context,
    required Widget child,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75, // Initial height is 3/4 of the screen
          minChildSize: 0.25, // Minimum height when collapsed
          maxChildSize: 1.0, // Maximum height when expanded
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.fromLTRB(
                  12.0, 12.0, 12.0, MediaQuery.of(context).viewInsets.bottom),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Form(child: child),
              ),
            );
          },
        );
      },
    );
  }

  static Future<void> showModalBottomScrollSort({
    required BuildContext context,
    required Widget child,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Initial height is 3/4 of the screen
          minChildSize: 0.25, // Minimum height when collapsed
          maxChildSize: 1.0, // Maximum height when expanded
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.fromLTRB(
                  12.0, 12.0, 12.0, MediaQuery.of(context).viewInsets.bottom),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Form(child: child),
              ),
            );
          },
        );
      },
    );
  }

  static showModalBottom2(
      {required BuildContext context, required Widget child}) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
            child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(12),
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
                Container(
                  width: 55,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                SizedBox(height: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [child],
                ),
              ],
            ),
          ),
        ));
      },
    );
  }

  static mainGridView({
    required BuildContext context,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollPhysics? physics,
    bool shrinkWrap = true,
    bool addAutomaticKeepAlives = true,
    Axis scrollDirection = Axis.vertical,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    int crossAxisCount = 2,
    int height = 380,
    int indexUp = 0,
    double? childAspectRatio,
    ScrollController? scrollController,
    EdgeInsetsGeometry? padding,
  }) {
    return GridView.count(
      controller: scrollController,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      physics: physics ?? NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      shrinkWrap: shrinkWrap,
      padding: padding,
      childAspectRatio: childAspectRatio ??
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.2),
      children: List.generate(itemCount, (index) => itemBuilder(context, index))
          .toList(),
    );
  }

  static mainGridViewPagination({
    required BuildContext context,
    // required int itemCount,
    required PagingController<int, Type> pagingController,
    required PagedChildBuilderDelegate<Type> builderDelegate,
    required Type typeClass,
    ScrollPhysics? physics,
    bool shrinkWrap = true,
    bool addAutomaticKeepAlives = true,
    Axis scrollDirection = Axis.vertical,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    int crossAxisCount = 2,
    int height = 380,
    int indexUp = 0,
    double? childAspectRatio,
    ScrollController? scrollController,
    EdgeInsetsGeometry? padding,
  }) {
    return PagedGridView<int, Type>(
      shrinkWrap: shrinkWrap,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      physics: physics ?? NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio ??
            MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.2),
      ),
      pagingController: pagingController,
      builderDelegate: builderDelegate,
    );
  }

  static newArrivalGridView({
    required BuildContext context,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollPhysics? physics,
    bool shrinkWrap = true,
    bool addAutomaticKeepAlives = true,
    Axis scrollDirection = Axis.vertical,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    int crossAxisCount = 1,
    int height = 380,
    int indexUp = 0,
    double? childAspectRatio,
    ScrollController? scrollController,
    EdgeInsetsGeometry? padding,
  }) {
    return GridView.count(
      controller: scrollController,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      physics: physics ?? NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      shrinkWrap: shrinkWrap,
      padding: padding,
      childAspectRatio: childAspectRatio ??
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.2),
      children: List.generate(
          itemCount, (index) => itemBuilder(context, index + indexUp)).toList(),
    );
  }

  static horizontalGridView({
    required BuildContext context,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollPhysics? physics,
    bool shrinkWrap = true,
    bool addAutomaticKeepAlives = true,
    Axis scrollDirection = Axis.horizontal,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    int crossAxisCount = 1,
    int height = 380,
    int indexUp = 0,
    double? childAspectRatio,
    ScrollController? scrollController,
    EdgeInsetsGeometry? padding,
  }) {
    return GridView.count(
      controller: scrollController,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      physics: physics ?? NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      shrinkWrap: shrinkWrap,
      padding: padding,
      childAspectRatio: childAspectRatio ??
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 4.5),
      children: List.generate(
          itemCount, (index) => itemBuilder(context, index + indexUp)).toList(),
    );
  }

  static horizontalGridView2({
    required BuildContext context,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollPhysics? physics,
    bool shrinkWrap = true,
    bool addAutomaticKeepAlives = true,
    Axis scrollDirection = Axis.horizontal,
    double crossAxisSpacing = 0.0,
    double mainAxisSpacing = 0.0,
    int crossAxisCount = 1,
    int height = 380,
    int indexUp = 0,
    double? childAspectRatio,
    ScrollController? scrollController,
    EdgeInsetsGeometry? padding,
  }) {
    return ListView.builder(
      controller: scrollController,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      physics: physics ?? NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
    // return GridView.count(
    //   controller: scrollController,
    //   addAutomaticKeepAlives: addAutomaticKeepAlives,
    //   physics: physics ?? NeverScrollableScrollPhysics(),
    //   scrollDirection: scrollDirection,
    //   crossAxisCount: crossAxisCount,
    //   mainAxisSpacing: mainAxisSpacing,
    //   crossAxisSpacing: crossAxisSpacing,
    //   shrinkWrap: shrinkWrap,
    //   padding: padding,
    //   childAspectRatio: childAspectRatio ??
    //       MediaQuery.of(context).size.width /
    //           (MediaQuery.of(context).size.height / 4.5),
    //   children: List.generate(
    //       itemCount, (index) => itemBuilder(context, index + indexUp)).toList(),
    // );
  }

  static mainFormLayout({
    required List<Widget> children,
    required Widget buttonWidget,
  }) {
    return Column(children: [
      Expanded(child: ListView(children: children)),
      buttonWidget,
    ]);
  }
}
