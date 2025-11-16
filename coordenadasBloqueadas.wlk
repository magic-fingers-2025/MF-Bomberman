import wollok.game.*
import fondo.*

object coordenadasBloqueadas {

   method morir(){}

  // conjunto inicial con los bordes del mapa
  // si no lo declaro como variable no me deja hacer reset
  var property posiciones = #{}

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
    posiciones = #{}
  }


  method bordes() {

  // horizontal bordes inferior y superior
  (0 .. 21).forEach { x =>
    self.agregarCoordenada([x, 0])   
    self.agregarCoordenada([x, 19])   
  }

  // vertical bordes izquierdo y derecho
  (0 .. 19).forEach { y =>
    self.agregarCoordenada([0, y])    
    self.agregarCoordenada([21, y])   
  }
}


  method nivel1(){ // x , y
    const listaNivel1 = #{[3,3],[3,6],[3,9],[3,13],[3,16],
                          [5,3],[5,6],[5,9],[5,13],[5,16],
                          [8,3],[8,6],[8,9],[8,13],[8,16],
                          [10,3],[10,6],[10,9],[10,13],[10,16],
                          [13,3],[13,6],[13,9],[13,13],[13,16],
                          [15,3],[15,6],[15,9],[15,13],[15,16],
                          [18,3],[18,6],[18,9],[18,13],[18,16]
                          }
    self.agregarCoordenadas(listaNivel1)
  }

  method nivel2(){

    self.nivel1()

    const listaNivel2 = #{[4,4], [17,4] , [9,8], [14,11], [14,14], [6,14]}

    self.agregarCoordenadas(listaNivel2)
  }
}
