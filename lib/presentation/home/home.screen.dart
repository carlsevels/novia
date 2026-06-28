import 'dart:ui';

import 'package:alecita/presentation/detalles/controllers/detalles.controller.dart';
import 'package:alecita/presentation/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      return CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              leading: Text(
                "Nuestra historia",
                style: TextStyle(color: CupertinoColors.black),
              ),
              largeTitle: Text('C & A'),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: CupertinoColors.systemGrey5,
                        ),
                      ),
                      child: const Text(
                        "Hola mi amor, te hice estos recuerditos y si entras a un recuerdo verás una opinion mía, espero que te guste mucho muchooo!",
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 📜 LISTA CON MEJOR ESPACIADO VISUAL
                  ListView.builder(
                    itemCount: controller.evento.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: RecuerdoRomantico(
                          path: controller.evento[index].portada,
                          descripcion:
                              controller.evento[index].descripcionCorta,
                          fecha: controller.evento[index].fecha,
                          evento: controller.evento[index],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: CupertinoColors.systemGrey5,
                        ),
                      ),
                      child: const Text(
                        "Faltan muchisimos recuerdos amor pero siento que estos son los más importantes (todos los son)",
                        style: TextStyle(color: CupertinoColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class RecuerdoRomantico extends StatelessWidget {
  final String path;
  final String? titulo;
  final String fecha;
  final String? descripcion;
  final Detalles evento; // 👈 IMPORTANTE

  const RecuerdoRomantico({
    super.key,
    required this.path,
    this.titulo,
    required this.fecha,
    this.descripcion,
    required this.evento,
  });

  @override
  Widget build(BuildContext context) {
    final bool esAniversario = evento.mesAniversario == true;
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: () {
        Get.to(
          () => DetallesScreen(),
          arguments: evento,
          binding: BindingsBuilder(() {
            // Aquí le decimos a GetX: "Cuando abras DetallesScreen,
            // crea esta instancia de DetallesController y guárdala"
            Get.put(
              DetallesController(
                mesAniversario: evento.mesAniversario ?? false,
                eventoActual: evento,
              ),
            );
          }),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        height: 210,
        transform: Matrix4.identity()..scale(esAniversario ? 1.03 : 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: esAniversario
                  ? Colors.green.withOpacity(0.45)
                  : Colors.black.withOpacity(0.25),
              blurRadius: esAniversario ? 28 : 18,
              offset: const Offset(0, 10),
            ),
            if (esAniversario)
              BoxShadow(
                color: Colors.green.withOpacity(0.25),
                blurRadius: 40,
                spreadRadius: 2,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // IMAGEN
              Positioned.fill(
                  child: Image.asset(
                path,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              )),

              // GRADIENTE ESPECIAL
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: esAniversario
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 136, 236, 139)
                                  .withOpacity(0.25),
                              Colors.green.withOpacity(0.35),
                              Colors.black.withOpacity(0.85),
                            ],
                          )
                        : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.35),
                              Colors.black.withOpacity(0.85),
                            ],
                          ),
                  ),
                ),
              ),

              if (esAniversario)
                const Positioned(
                  top: 12,
                  left: 12,
                  child: Icon(
                    CupertinoIcons.heart_circle_fill,
                    color: Colors.pinkAccent,
                    size: 32,
                  ),
                ),

              // 💖 FAVORITO
              if (evento.isFavorite == true)
                Positioned(
                  top: 12,
                  right: esAniversario ? 90 : 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "favorito",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // 💍 BADGE ANIVERSARIO
              if (esAniversario)
                Positioned(
                  top: 48,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.pinkAccent),
                    ),
                    child: const Text(
                      "ANIVERSARIO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),

              // CONTENIDO
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fecha.toUpperCase(),
                      style: TextStyle(
                        color: esAniversario
                            ? Colors.pinkAccent.withOpacity(0.9)
                            : Colors.white70,
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      evento.descripcionCorta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
