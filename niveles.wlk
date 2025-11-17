
import sonidos.*
import interfaz.*
import personajes.*


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
    self.agregarCoordenada([x, 20])   
  }

  // vertical bordes izquierdo y derecho
  (0 .. 21).forEach { y =>
    self.agregarCoordenada([0, y])    
    self.agregarCoordenada([22, y])   
  }
}


}