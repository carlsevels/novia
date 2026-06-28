import 'dart:math';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController with StateMixin<List<EventoMedio>> {
  // =========================
  final Map<String, VideoPlayerController> videoControllers = {};

  late ConfettiController controllerCenter;

  final header = <EventoMedio>[
    EventoMedio(path: 'assets/images/imagen2.jpeg', isVideo: false),
    EventoMedio(path: 'assets/images/imagen3.jpeg', isVideo: false),
    EventoMedio(path: 'assets/images/imagen4.jpeg', isVideo: false),
  ].obs;

  final evento = <Detalles>[
    Detalles(
      mesAniversario: false,
      isFavorite: false,
      portada: 'assets/images/imagen3.jpeg',
      isVideo: false,
      fecha: "12 de Marzo del 2026",
      descripcionCorta: "Esta es la primer foto que te tomé <3",
      descripcionLarga:
          "Cuando te di ese llaverito de Gignac en realidad era porque queria que tuvieras algo para que pensaras en mi, era mi manera de demostrarte cariño y te llevaras algo mío, ahí la verdad ya me gustabas y a esta foto en especifico le tengo mucho cariño",
    ),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: 'assets/images/romeos2.jpeg',
        isVideo: false,
        fecha: "16 de Marzo del 2026",
        descripcionCorta: "Nuestra primera citaaaa!",
        cancion: "audios/risk.mp3",
        descripcionLarga:
            "Aqui la verdad estaba bien emocionado porque ibamos a tener nuestra primera salidita, nunca me pasó por la cabeza que fueramos a salir algun día, fue un dia muy especial, a pesar de que nos habiamos visto todos los dias en la biblioteca senti como su fuera la primera vez que te veía, me puse muy nervioso a decir verdad, nunca pense que iba a ser el inicio de algo muy bonito <3",
        listaImagenes: [
          EventoMedio(path: "assets/images/romeos.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/romeos2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/romeos3.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/marco2.jpeg",
        isVideo: false,
        cancion: "audios/caroline.mp3",
        fecha: "18 de Marzo del 2026",
        descripcionCorta: "Nuestra segunda cita en el museo marco c:",
        descripcionLarga:
            "En esta cita era cuando intente abrazarte mas y agarrate la manita JAJAJA me dio mucha pena pero se logro poquito, de mis citas favoritas",
        listaImagenes: [
          EventoMedio(path: "assets/images/marco.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/marco7.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/marco2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/marco4.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/marco5.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/marco6.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        cancion: "audios/247.mp3",
        portada: "assets/images/ajolote3.jpeg",
        isVideo: false,
        fecha: "22 de Marzo del 2026",
        descripcionCorta: "Este día hicimos muchas cosas",
        descripcionLarga:
            "Me gustó mucho este día porque salimos al museo de historia, despues fuimos a barrio antiguo a caminar y despues fuimos a comer al Ajolote, fue un dia especial y me encantó bastante, recuerdo que ya me iba a mi casa para tomar clases de ingles pero las cancelaron JAJA y solo pensé en que queria seguir contigo",
        listaImagenes: [
          EventoMedio(path: "assets/images/ajolote.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/ajolote2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/ajolote3.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/ajolote4.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/ajolote5.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/baseball.jpeg",
        isVideo: false,
        cancion: "audios/karma.mp3",
        fecha: "28 de Marzo del 2026",
        descripcionCorta: "Cuando fuimos al Museo de Baseball",
        descripcionLarga:
            "Este día estuvo padre la salidita al museo, la verdad si tenia muchas ganas de ir y que bueno que me acompañaste, me divertí muchisimo ese día, me encanto bastante!",
        listaImagenes: [
          EventoMedio(path: "assets/images/baseball.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/baseball4.jpeg", isVideo: false),
          EventoMedio(path: "assets/videos/baseball2.jpeg", isVideo: false),
          EventoMedio(path: "assets/videos/baseball3.jpeg", isVideo: false),
          EventoMedio(path: "assets/videos/baseball5.mp4", isVideo: true),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/pulseras3.jpeg",
        isVideo: false,
        cancion: "audios/milagro.mp3",
        fecha: "08 de Abril del 2026",
        descripcionCorta: "Día de las pulseras",
        descripcionLarga:
            '''Jamas habia hecho pulseras en mi vida, era la priemra vez que hacía la verdad me gusto bastante hacerla y quedaron muy bonitas las 2, aunque la tuya fue la mejor <3''',
        listaImagenes: [
          EventoMedio(path: "assets/images/pulseras.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/pulseras2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/pulseras3.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/pulseras4.jpeg", isVideo: false),
          EventoMedio(path: "assets/videos/pulseras5.mp4", isVideo: true),
        ]),
    Detalles(
        mesAniversario: true,
        isFavorite: false,
        portada: "assets/images/novios3.jpeg",
        isVideo: false,
        fecha: "05 de Mayo del 2026",
        descripcionCorta: "Novioooos!",
        cancion: "audios/novios.mp3",
        descripcionLarga:
            '''Qué te digo amor, eres una mujer maravillosa, increible, linda, muy guapa, atenta, amable, eres simplemente perfecta amor, la mejor novia del mundo, me tratas muy bien siempre y me encanta compartir muchos momentos contigo.
            Yo espero seguir toda mi vida contigo, estar en buenos y malos momentos, yo no me veo con otra mujer que no seas tu, te amo tanto mi vida''',
        listaImagenes: [
          EventoMedio(path: "assets/images/novios.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/novios2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/novios3.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/novios4.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/cine2.jpeg",
        isVideo: false,
        fecha: "15 de Mayo del 2026",
        descripcionCorta: "Salidita al cine!",
        cancion: "audios/wishList.mp3",
        descripcionLarga:
            '''Este dia estuvo muy lindo, nuestra primera salida al cineee, estabas muy emocionada por ver tu pelicula favorita (No recuerdo como se llama jejej) pero me gusto mucho que me hayas invitado a verla y como siempre yo super encantado de acompañarte amor''',
        listaImagenes: [
          EventoMedio(path: "assets/images/cine.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/cine2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/cine3.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/potter2.jpeg",
        isVideo: false,
        fecha: "16 de Mayo del 2026",
        descripcionCorta:
            "Cuando fuimos a comer al restaurante de Harry Potter",
        cancion: "audios/potter.mp3",
        descripcionLarga:
            '''Hace muchisimos años que queria ir ahí amor, jamas pense que fuera a ir una una mujer tan preciosota y que tambien le gustara Harry Potter c:''',
        listaImagenes: [
          EventoMedio(path: "assets/images/potter.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/potter2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/potter3.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/potter4.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/catrinas.jpeg",
        isVideo: false,
        fecha: "31 de Mayo del 2026",
        descripcionCorta: "Catrinas ñamñamñam",
        cancion: "audios/vidaEntera.mp3",
        descripcionLarga:
            '''Buena comida, buen restaurant y con una mujerona como tuuuu, va a sonar muy reprtitivo pero me encantó ese dia, realmente me gusta pasar el tiempo contigo, lo haces muy divertido, alegre y eso lo transmites''',
        listaImagenes: [
          EventoMedio(path: "assets/images/catrinas2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/catrinas3.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/catrinas4.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/mundial3.jpeg",
        isVideo: false,
        fecha: "12 de Junio del 2026",
        descripcionCorta: "Nuestro primer mundial",
        cancion: "audios/mundial.mp3",
        descripcionLarga:
            '''Cuando fuimos a ver a lo Coreanos como ganaron 2-1 JAJAJ me gusto mucho aunque haya sido un ratito mi amor, me gusta que sigas mis planes FIFAS JAJAJAc:''',
        listaImagenes: [
          EventoMedio(path: "assets/images/mundial.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/mundial2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/mundial3.jpeg", isVideo: false),
        ]),
    Detalles(
        mesAniversario: false,
        isFavorite: false,
        portada: "assets/images/gfirme.jpeg",
        isVideo: false,
        fecha: "25 de Junio del 2026",
        descripcionCorta: "Y puro Grupo Firmeee",
        cancion: "audios/pideme.mp3",
        descripcionLarga:
            '''Fui a ver a unos de mis grupos favoritos con mi noviaaa, lo mejor de lo mejor y tu lo hiciste auuun mucho mejor mi vida, te amooooo''',
        listaImagenes: [
          EventoMedio(path: "assets/images/gfirme.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/gfirme2.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/gfirme3.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/gfirme4.jpeg", isVideo: false),
          EventoMedio(path: "assets/images/gfirme5.jpeg", isVideo: false),
          EventoMedio(path: "assets/videos/gfirme6.mp4", isVideo: true),
        ]),
  ].obs;

  // =========================
  // INIT
  // =========================
  @override
  void onInit() {
    super.onInit();

    controllerCenter = ConfettiController(
      duration: const Duration(seconds: 10),
    );

    change(header, status: RxStatus.success());
  }

  // =========================
  // VIDEO CONTROLLER CACHE
  // =========================
  Future<VideoPlayerController> getController(String path) async {
    if (videoControllers.containsKey(path)) {
      return videoControllers[path]!;
    }

    final controller = VideoPlayerController.asset(path);

    try {
      await controller.initialize();
      controller.setLooping(true);
      controller.setVolume(0.0);
      await controller.play();

      videoControllers[path] = controller;
      return controller;
    } catch (e) {
      debugPrint("Error inicializando video $path: $e");
      rethrow;
    }
  }

  // =========================
  // STAR SHAPE (CONFETTI)
  // =========================
  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;

    final path = Path();
    final fullAngle = degToRad(360);

    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );

      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }

    path.close();
    return path;
  }

  // =========================
  // DISPOSE
  // =========================
  @override
  void onClose() {
    controllerCenter.dispose();

    for (var controller in videoControllers.values) {
      controller.dispose();
    }

    super.onClose();
  }
}

// =========================
// MODELS
// =========================

class EventoMedio {
  final String path;
  final bool isVideo;
  final String fecha;

  EventoMedio({
    required this.path,
    required this.isVideo,
    this.fecha = "",
  });
}

class Detalles {
  final String portada;
  final bool isVideo;
  final String fecha;
  final String descripcionCorta;
  final String? descripcionLarga;
  final String? ruta;
  final List<EventoMedio>? listaImagenes;
  final bool? isFavorite;
  final bool? mesAniversario;

  final String? cancion;

  Detalles({
    required this.portada,
    required this.isVideo,
    required this.descripcionCorta,
    this.fecha = "",
    this.cancion,
    this.descripcionLarga,
    this.ruta,
    this.listaImagenes,
    this.isFavorite,
    this.mesAniversario,
  });
}
