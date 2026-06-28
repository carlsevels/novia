import 'package:get/get.dart';
import 'package:alecita/presentation/home/controllers/home.controller.dart';
import 'package:audioplayers/audioplayers.dart';

class DetallesController extends GetxController with StateMixin {
  final HomeController homeController = Get.find<HomeController>();

  final bool mesAniversario;
  final Detalles eventoActual;
  DetallesController({
    required this.mesAniversario,
    required this.eventoActual,
  });
  final isPlaying = true.obs;
  late final AudioPlayer player;
  bool _isLoaded = false;

  @override
  void onInit() {
    super.onInit();

    player = AudioPlayer();

    print("mesAniversario: $mesAniversario");

    if (mesAniversario) {
      homeController.controllerCenter.play();
    } else {
      homeController.controllerCenter.stop();
    }
    _playAudio();
    change(null, status: RxStatus.success());
  }

  Future<void> _playAudio() async {
    final cancion = eventoActual.cancion;

    if (cancion == null || cancion.isEmpty) return;

    await player.setReleaseMode(ReleaseMode.stop);

    await player.stop();

    await player.setSource(
      AssetSource(cancion),
    );

    await player.resume();
  }

  Future<void> toggleAudio() async {
    final cancion = eventoActual.cancion;
    if (cancion == null || cancion.isEmpty) return;

    if (isPlaying.value) {
      await player.pause();
      isPlaying.value = false;
    } else {
      if (!_isLoaded) {
        await player.setSource(AssetSource(cancion));
        _isLoaded = true;
      }

      await player.resume();
      isPlaying.value = true;
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
