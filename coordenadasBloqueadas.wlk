import wollok.game.*
import fondo.*

object coordenadasBloqueadas {

  // conjunto inicial con los bordes del mapa
  const property posiciones = #{}

  // ====== MÉTODOS PRINCIPALES ======
  
  // para registrar nuevas coordenadas bloqueadas
  method agregarCoordenada(coordenada) {
    posiciones.add(coordenada)
  }

  // para registrar varias de una vez
  method agregarCoordenadas(lista) {
    lista.forEach({ c => posiciones.add(c) })
  }

  // verificar si una celda está bloqueada
  method estaBloqueada(posicion) = posiciones.any({ bloqueada =>
        bloqueada.get(0) == posicion.x() and bloqueada.get(1) == posicion.y()})

  // por si necesitás reiniciar el tablero en un nuevo nivel
  method reset() {
    //posiciones = coordenadasBorde.posiciones()
  }
}
