import 'package:flutter/material.dart';
import 'package:svga_example/svga_sample_screen.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:svgaplayer_flutter/proto/svga.pbserver.dart';
import 'package:svgaplayer_flutter/proto/svga.pb.dart';

class HomeScreen extends StatelessWidget {
  final samples = const <String>[
    "assets/angel.svga",
    "assets/pin_jump.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/posche.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/kingset.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/rose.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/halloween.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/heartbeat.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/EmptyState.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/HamburgerArrow.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/PinJump.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/TwitterHeart.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/Walkthrough.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/matteBitmap.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/matteRect.svga",
    "https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/mutiMatte.svga",
  ].map((e) => [e.split('/').last, e]).toList(growable: false);

  // callback for register dynamicItem
  final dynamicSamples = <String, void Function(MovieEntity entity)>{
    "kingset.svga": (entity) => entity.dynamicItem
      ..setText(
          TextPainter(
              text: const TextSpan(
                  text: "Hello, World!",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))),
          "banner")
      ..setImageWithUrl(
          "https://github.com/PonyCui/resources/blob/master/svga_replace_avatar.png?raw=true",
          "99")
      ..setDynamicDrawer((canvas, frameIndex) {
        canvas.drawRect(const Rect.fromLTWH(0, 0, 88, 88),
            Paint()..color = Colors.white); // draw by yourself.
      }, "banner"),
  };

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SVGA Flutter Samples'),
      ),
      body: ListView.separated(
          itemCount: samples.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(samples[index].first),
                subtitle: Text(samples[index].first),
                onTap: () => _goToSample(context, samples[index]));
          }),
    );
  }

  void _goToSample(context, List<String> sample) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SVGASampleScreen(
            name: sample.first,
            image: sample.last,
            dynamicCallback: dynamicSamples[sample.first],
          );
        },
      ),
    );
  }
}
