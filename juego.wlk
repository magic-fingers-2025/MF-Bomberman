import wollok.game.*
import personajes.*
import sonidos.*
import imagenes.*
import interfaz.*
import bomba.*


object juego {
  var property nivel = 1
  var property mapaNivel = mapaNivel1

  method iniciar() {
    game.width(22)
    game.height(20)
    game.cellSize(48)
    game.title("Bomberman")
    game.addVisual(menu)
    sonido.ejecutar(musicaInicio)
    game.start()
    self.iniciarTeclado()
  }

  method iniciarTeclado(){
    
    keyboard.w().onPressDo{ bomberman.subir() }

    keyboard.s().onPressDo{ bomberman.bajar() }

    keyboard.a().onPressDo{ bomberman.izquierda() }

    keyboard.d().onPressDo{ bomberman.derecha() }

    keyboard.enter().onPressDo({
      game.removeVisual(menu)
      sonido.detener(musicaInicio)
      mapa.mostrarMapaSegunNivel(self.mapaNivel())
      coordenadasBloqueadas.bordes()
      coordenadasBloqueadas.nivel1()
      game.addVisual(bomberman)
      keyboard.space().onPressDo({bomberman.ponerBombaConExplosion() })

      const enemigoA = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
      const enemigoB = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")



   // ======== Interfaz ========
   // son las vidas representadas como corazones
    interfaz.mostrar()
    //interfaz.reiniciar()



    // ======== Colisiones ========
    game.onCollideDo(bomberman, { otro =>
      if (otro == enemigoA or otro == enemigoB or otro == explosion) {
        interfaz.perderUnaVida()
        bomberman.position(game.center())
      }}
    )
  
      
    }

  )


  }
  
  

  // cargar coordenadas de borde y mapa 1
  //coordenadasBloqueadas.nivel1()
  
  //
  // ======== Borde del mapa ============
  /*
  const bordeInferior = new MuroBorde(tipo = bloqueSur)
  bordeInferior.concatenarMurosHorizontalesSegunTipo()

  const bordeSuperior = new MuroBorde(tipo = bloqueNorte)
  bordeSuperior.concatenarMurosHorizontalesSegunTipo()

  const bordeOeste = new MuroBorde(tipo = bloqueOeste)
  bordeOeste.concatenarMurosVerticaleslesSegunTipo()

  const bordeEste = new MuroBorde(tipo = bloqueEste)
  bordeEste.concatenarMurosVerticaleslesSegunTipo()

  const esquinas = new MuroBorde(tipo = bloqueEsquina)
  esquinas.generarEsquinas()
  */
  // ======== Muros internos ============
  //murosInternos.generar()


  // ===================================
  
  // personaje principal
  //evitar poner add visual characters para que no mal use las flechas
   

  //const enemigoA = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
  //game.addVisual(enemigoA)
  //enemigoA.iniciarMovimiento()

  //const enemigoB = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")
  //game.addVisual(enemigoB)

  //enemigoB.iniciarMovimiento()
 
 

  

  
  //stageTheme.shouldLoop(true)
  //stageTheme.play()
  
  // fondo
  //game.boardGround("piso2.png") // Es fijo. Si queremos un fondo que se mueva hay que usar un hack: definir un objeto que sea el fondo y cuyo tamaño sea el tamaño del tablero.

  // para que arranque el juego
  
}

