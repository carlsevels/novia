import 'package:get/get.dart';

import '../../../../presentation/detalles/controllers/detalles.controller.dart';

class DetallesControllerBinding extends Bindings {
  final bool mesAniversario;
  final dynamic eventoActual; // Usa dynamic o tu clase base

  DetallesControllerBinding({
    required this.mesAniversario,
    required this.eventoActual,
  });

  @override
  void dependencies() {
    // Solo registra una vez
    Get.put<DetallesController>(
      DetallesController(
        mesAniversario: mesAniversario,
        eventoActual: eventoActual,
      ),
      permanent: false,
    );
  }
}
