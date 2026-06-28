import 'package:alecita/presentation/home/controllers/home.controller.dart';
import 'package:get/get.dart';

import '../../../../presentation/detalles/controllers/detalles.controller.dart';

class DetallesControllerBinding extends Bindings {
  final bool mesAniversario;
  final Detalles eventoActual;

  DetallesControllerBinding({
    required this.mesAniversario,
    required this.eventoActual,
  });

  @override
  void dependencies() {
    Get.lazyPut(
      () => DetallesController(
        mesAniversario: mesAniversario,
        eventoActual: eventoActual,
      ),
    );
  }
}
