import 'package:cine_favorite/core/helper/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyContent extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget? content;
  final String lottie;
  final bool? withNoRepeatMode;
  final double? lottieSize;

  const EmptyContent({
    required this.title,
    required this.lottie,
    this.content,
    this.subtitle,
    this.withNoRepeatMode,
    this.lottieSize,
    super.key,
  });

  @override
  State<EmptyContent> createState() => _EmptyContentState();
}

class _EmptyContentState extends State<EmptyContent>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    if (widget.withNoRepeatMode ?? false) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );
      controller!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller!.stop();
        }
      });
      controller!.forward();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Center(
              child: SizedBox(
            height: widget.lottieSize ?? 300,
            child: LottieBuilder.asset(
              widget.lottie,
              height: widget.lottieSize ?? 300,
              controller: widget.withNoRepeatMode ?? false ? controller : null,
              frameRate: FrameRate.max,
              fit: BoxFit.contain,
            ),
          )),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: AppTextStyles.title.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 73, 134, 180),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        widget.subtitle?.isNotEmpty ?? false
            ? Text(
                widget.subtitle ?? "",
                style: const TextStyle(color: Color.fromRGBO(141, 141, 141, 1)),
              )
            : const SizedBox.shrink(),
        widget.content ?? const SizedBox.shrink()
      ],
    );
  }
}
