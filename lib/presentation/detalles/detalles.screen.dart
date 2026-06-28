import 'package:alecita/presentation/detalles/controllers/detalles.controller.dart';
import 'package:alecita/presentation/home/controllers/home.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:typed_data';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class DetallesScreen extends GetView<DetallesController> {
  final String? descripcionCorta;
  final String? descripcionLarga;
  final String? fecha;
  final String? portada;
  final List<EventoMedio>? listaImagenes;
  final bool? esFavorito;
  final bool? mesAniversario;

  const DetallesScreen({
    super.key,
    this.descripcionCorta,
    this.descripcionLarga,
    this.fecha,
    this.portada,
    this.listaImagenes,
    this.esFavorito,
    this.mesAniversario,
  });
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return CupertinoPageScaffold(
        backgroundColor:
            mesAniversario == true ? Colors.green[100] : Colors.white,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                /// ================= HERO STYLE MEMORIES =================
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      /// ================= HERO FULL SCREEN =================
                      SizedBox(
                        height: 520,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (portada != null)
                              Image.asset(
                                portada!,
                                fit: BoxFit.cover,
                              ),

                            /// gradiente cinematográfico
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.25),
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.65),
                                  ],
                                ),
                              ),
                            ),

                            /// texto encima del hero
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    fecha?.toUpperCase() ?? "",
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    descripcionCorta ?? "",
                                    style: const TextStyle(
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ================= CONTENIDO SHEET =================
                      Container(
                        margin: const EdgeInsets.only(top: 480),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 26,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (esFavorito ?? false)
                                  Positioned(
                                    top: 50,
                                    right: 20,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.25),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                if (esFavorito ?? false)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.red,
                                    ),
                                    child: const Text(
                                      "Favoritos",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            if (descripcionLarga != null &&
                                descripcionLarga!.isNotEmpty)
                              Text(
                                descripcionLarga!,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.7,
                                  color: Colors.black.withOpacity(0.72),
                                ),
                              ),

                            const SizedBox(height: 26),

                            /// ================= GALERÍA =================
                            if (listaImagenes != null &&
                                listaImagenes!.isNotEmpty) ...[
                              const Text(
                                "Momentos juntos",
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 2,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                height: 140,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listaImagenes!.length,
                                  itemBuilder: (context, index) {
                                    final path = listaImagenes![index].path;
                                    final esVideo =
                                        path.toLowerCase().endsWith('.mp4');

                                    return GestureDetector(
                                      onTap: () {
                                        if (esVideo) {
                                          Get.to(
                                              () => PantallaVideo(path: path));
                                        } else {
                                          Get.to(
                                              () => PantallaImagen(path: path));
                                        }
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        width: 120,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              esVideo
                                                  ? VideoThumbnailWidget(
                                                      path: path)
                                                  : Image.asset(
                                                      path,
                                                      fit: BoxFit.cover,
                                                    ),
                                              if (esVideo)
                                                Container(
                                                  color: Colors.black26,
                                                  child: const Icon(
                                                    CupertinoIcons
                                                        .play_circle_fill,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],

                            const SizedBox(height: 60),
                          ],
                        ),
                      ),

                      /// ================= CONFETTI =================
                      Positioned.fill(
                        child: IgnorePointer(
                          child: ConfettiWidget(
                            confettiController:
                                controller.homeController.controllerCenter,
                            blastDirectionality: BlastDirectionality.explosive,
                            emissionFrequency: 0.05,
                            numberOfParticles: 12,
                            gravity: 0.25,
                            shouldLoop: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// ================= NAVBAR FLUIDO iOS =================
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.05),
                        ),
                      ),
                      child: Row(
                        children: [
                          /// BOTÓN ATRÁS iOS
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(
                                CupertinoIcons.back,
                                size: 26,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "Recuerdo",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ),

                          const SizedBox(width: 44), // balance visual
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PantallaImagen extends StatelessWidget {
  final String path;
  const PantallaImagen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: Stack(
        children: [
          // Zoom interactivo
          InteractiveViewer(
            minScale: 1.0,
            maxScale: 4.0,
            child: Center(child: Image.asset(path)),
          ),
          // Botón cerrar minimalista
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(CupertinoIcons.xmark_circle_fill,
                  color: CupertinoColors.systemGrey, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class PantallaVideo extends StatefulWidget {
  final String path;
  const PantallaVideo({super.key, required this.path});

  @override
  State<PantallaVideo> createState() => _PantallaVideoState();
}

class _PantallaVideoState extends State<PantallaVideo> {
  late VideoPlayerController _controller;

  bool _showControls = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.path)
      ..initialize().then((_) {
        setState(() {});
        _controller
          ..play()
          ..setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _seekForward() {
    final pos = _controller.value.position + const Duration(seconds: 10);
    _controller.seekTo(pos);
  }

  void _seekBackward() {
    final pos = _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(pos < Duration.zero ? Duration.zero : pos);
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// ================= VIDEO FULL SCREEN =================
            _controller.value.isInitialized
                ? Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  )
                : const CupertinoActivityIndicator(radius: 20),

            /// ================= CONTROLS =================
            AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showControls ? 1 : 0,
              child: IgnorePointer(
                ignoring: !_showControls,
                child: Stack(
                  children: [
                    /// DARK OVERLAY
                    Container(
                      color: Colors.black26,
                    ),

                    /// TOP CLOSE
                    Positioned(
                      top: 60,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: CupertinoColors.white,
                          size: 34,
                        ),
                      ),
                    ),

                    /// CENTER PLAY / PAUSE
                    Center(
                      child: GestureDetector(
                        onTap: _togglePlay,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _controller.value.isPlaying
                                ? CupertinoIcons.pause_fill
                                : CupertinoIcons.play_fill,
                            color: CupertinoColors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),

                    /// BOTTOM CONTROLS
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 40,
                      child: Column(
                        children: [
                          /// PROGRESS BAR
                          VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              playedColor: CupertinoColors.systemGreen,
                              bufferedColor: Colors.white24,
                              backgroundColor: Colors.white10,
                            ),
                          ),

                          const SizedBox(height: 14),

                          /// BUTTONS ROW
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _seekBackward,
                                child: const Icon(
                                  CupertinoIcons.gobackward_10,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: _togglePlay,
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? CupertinoIcons.pause_fill
                                      : CupertinoIcons.play_fill,
                                  color: Colors.white,
                                  size: 34,
                                ),
                              ),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: _seekForward,
                                child: const Icon(
                                  CupertinoIcons.goforward_10,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoThumbnailWidget extends StatefulWidget {
  final String path;

  const VideoThumbnailWidget({
    super.key,
    required this.path,
  });

  @override
  State<VideoThumbnailWidget> createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  Uint8List? thumbnail;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    final bytes = await VideoThumbnail.thumbnailData(
      video: widget.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 300,
      quality: 75,
    );

    if (mounted) {
      setState(() {
        thumbnail = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (thumbnail == null) {
      return Container(
        width: 120,
        height: 120,
        color: CupertinoColors.systemGrey5,
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return Image.memory(
      thumbnail!,
      width: 120,
      height: 120,
      fit: BoxFit.cover,
    );
  }
}
