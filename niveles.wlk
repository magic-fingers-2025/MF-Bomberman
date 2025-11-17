
import sonidos.*
import interfaz.*
import personajes.*

object coordenadasBorde{
  const property coordenadas = #{[0,0], [1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [8,0], [9,0], [10,0], [11,0], [12,0], [13,0], [14,0], [15,0], [16,0], [17,0], [18,0], [19,0], [20,0], [21,0], [22,0], [23,0], [24,0], [25,0], [26,0], [27,0], [28,0], [29,0], [30,0], [31,0], [32,0], [33,0], [34,0], [34,1], [34,2], [34,3], [34,4], [34,5], [34,6], [34,7], [34,8], [34,9], [34,10], [34,11], [34,12], [34,13], [34,14], [34,15], [34,16], [34,17], [34,18], [34,19], [33,19], [32,19], [31,19], [30,19], [29,19], [28,19], [27,19], [26,19], [25,19], [24,19], [23,19], [22,19], [21,19], [20,19], [19,19], [18,19], [17,19], [16,19], [15,19], [14,19], [13,19], [12,19], [11,19], [10,19], [9,19], [8,19], [7,19], [6,19], [5,19], [4,19], [3,19], [2,19], [1,19], [0,19], [0,18], [0,17], [0,16], [0,15], [0,14], [0,13], [0,12], [0,11], [0,10], [0,9], [0,8], [0,7], [0,6], [0,5], [0,4], [0,3], [0,2], [0,1]}
  

}

object niveles{
  const property listaDeNiveles = #{nivel1, nivel2}
}

object nivel1 {
  const property id = 1
  const property cantidadDeEnemigos = 2
  const property musicaDeFondo = musicaNivel1
  var property image = "map1-bomberman.png"
  method position() = game.origin()
  const property coordenadasBloqueadas = #{[3, 2], [3, 6], [3, 10], [3, 14], [3, 18], [7, 2], [7, 6], [7, 10], [7, 14], [7, 18], [11, 2], [11, 6], [11, 10], [11, 14], [11, 18], [15, 2], [15, 6], [15, 10], [15, 14], [15, 18], [19, 2], [19, 6], [19, 10], [19, 14], [19, 18]}

  method activarMusicaDeFondo(){
    sonido.reproducir(musicaDeFondo)
    interfaz.sonidoActual(musicaDeFondo)
  }

  method desactivarMusicaDeFondo(){
    sonido.detener(musicaDeFondo)
  }


  /*                      
  const enemigoA = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
  const enemigoB = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")

  
  method activarEnemigos(){    
    game.addVisual(enemigoA)
    game.addVisual(enemigoB)
    enemigoA.iniciarMovimiento()     
    enemigoB.iniciarMovimiento()

    game.onCollideDo(enemigoA, {elemento => if (elemento == bomberman){elemento.morir()}})
    game.onCollideDo(enemigoB, {elemento => if (elemento == bomberman){elemento.morir()}})
 
  }

  method activarMusicaDeFondo(){
    sonido.reproducir(musicaDeFondo)
    interfaz.sonidoActual(musicaDeFondo)
  }

  method desactivarMusicaDeFondo(){
    sonido.detener(musicaDeFondo)
  }
  
  method desactivarEnemigos(){    
    enemigoA.detenerMovimiento()
    enemigoB.detenerMovimiento()
    game.removeVisual(enemigoA)
    game.removeVisual(enemigoB)

  }
  
  method morir(){}

  */
  
}

object nivel2{
  const property id = 2
  const property cantidadDeEnemigos = 2
  const property musicaDeFondo = musicaNivel2
  var property image = "map2-bomberman.png"
  method position() = game.origin()
  const property coordenadasBloqueadas = #{[2,4], [2, 7], [2, 10], [2, 13], [2, 16],[5, 4], [5, 7], [5, 10], [5, 13], [5, 16], [8, 4], [8, 7], [8, 10], [8, 13], [8, 16], [11, 4], [11, 7], [11, 10], [11, 13], [11, 16], [14, 4], [14, 7], [14, 10], [14, 13], [14, 16], [17, 4], [17, 7], [17, 10], [17, 13], [17, 16], [20, 4], [20, 7], [20, 10], [20, 13], [20, 16], [5, 18], [11, 18], [17, 18], [8, 2], [14, 2]}

   method activarMusicaDeFondo(){
    sonido.reproducir(musicaDeFondo)
    interfaz.sonidoActual(musicaDeFondo)
  }

  method desactivarMusicaDeFondo(){
    sonido.detener(musicaDeFondo)
  }


  
}


object nivel0{
  const property cantidadDeEnemigos = 0
  const property musicaDeFondo = silencio

}

object coordenadasBloqueadas {

  // conjunto inicial con los bordes del mapa
  // si no lo declaro como variable no me deja hacer reset
  var property posiciones = #{}

  method morir(){}

  // ====== MÉTODOS PRINCIPALES ======
  
  // para registrar nuevas coordenadas bloqueadas
  method agregarCoordenada(coordenada) {
    posiciones.add(coordenada)
  }

  // para registrar varias de una vez
  method agregarCoordenadas(set) {
    set.forEach({ c => posiciones.add(c) })
  }

  method removerCoordenadas(set){
    set.forEach{c => posiciones.remove(c)}
  }

  // verificar si una celda está bloqueada
  method estaBloqueada(posicion) = posiciones.any({ bloqueada =>
        bloqueada.get(0) == posicion.x() and bloqueada.get(1) == posicion.y()})

  // por si necesitás reiniciar el tablero en un nuevo nivel
  method reset() {
    posiciones = #{}
  }


  method agregarBordes() {

  // horizontal bordes inferior y superior
  (0 .. 23).forEach { x =>
    self.agregarCoordenada([x, 0])   
    self.agregarCoordenada([x, 19])   
  }

  // vertical bordes izquierdo y derecho
  (0 .. 21).forEach { y =>
    self.agregarCoordenada([0, y])    
    self.agregarCoordenada([21, y])   
  }
}


}