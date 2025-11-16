import wollok.game.*
import imagenes.*



object interfaz {
    var property vidasRestantes = 3
    var property puntaje = 0
    

    const vidas = self.iniciarVidas()


// todavia no andan los puntos porque no realizamos 
    var marcador = object {
        method position() = game.at(9, 0)
        method draw(g) {
            g.setColor("white")
            g.drawText("Puntaje: " + interfaz.puntaje, 0, 0)
        }
    }

    method mostrar() {
        game.addVisual(vidas.get(0))
        game.addVisual(vidas.get(1))
        game.addVisual(vidas.get(2))
    }

  method perderUnaVida() {
    if (vidasRestantes > 1) {
      game.removeVisual(vidas.filter{v => v.id() == vidasRestantes}.first())
      vidasRestantes = vidasRestantes - 1
    }
    else{     
      game.addVisual(gameOverPantalla)
      game.schedule(3000, {self.reiniciar()})
    }
  }

  method sumarPuntos(cantidad) {
      puntaje = puntaje + cantidad
  }


  method reiniciar() {

      game.removeVisual(nivel1)
      game.removeVisual(gameOverPantalla)
      self.vidasRestantes(3)
      self.actualizar()
      self.puntaje(0)
      menu.iniciar()
      
  }

  method cambiarNivel(){

    // si no hay rivales en pantalla, pasar al siguiente- Hacemos que se cambie del 1 al 2 y asi
      if (nivel == 1) nivel = 2 else nivel = 1

  }

  
  const gameOverPantalla = object {
      method image() = "game-over.png"
      method position() = game.at(0.4, 0.4)
      method sonido() = "gameOver.mpeg"
      
  }

  method iniciarVidas(){
    var vida1 = corazon1
    var vida2 = corazon2
    var vida3 = corazon3

    return [vida1, vida2, vida3]
    
  }

   method actualizar() {
        game.removeVisual(vidas.get(0))
        game.removeVisual(vidas.get(1))
        game.removeVisual(vidas.get(2))
        self.mostrar() // ESTO
    }
}

object coordenadasBorde{
  const property coordenadas = #{[0,0], [1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [8,0], [9,0], [10,0], [11,0], [12,0], [13,0], [14,0], [15,0], [16,0], [17,0], [18,0], [19,0], [20,0], [21,0], [22,0], [23,0], [24,0], [25,0], [26,0], [27,0], [28,0], [29,0], [30,0], [31,0], [32,0], [33,0], [34,0], [34,1], [34,2], [34,3], [34,4], [34,5], [34,6], [34,7], [34,8], [34,9], [34,10], [34,11], [34,12], [34,13], [34,14], [34,15], [34,16], [34,17], [34,18], [34,19], [33,19], [32,19], [31,19], [30,19], [29,19], [28,19], [27,19], [26,19], [25,19], [24,19], [23,19], [22,19], [21,19], [20,19], [19,19], [18,19], [17,19], [16,19], [15,19], [14,19], [13,19], [12,19], [11,19], [10,19], [9,19], [8,19], [7,19], [6,19], [5,19], [4,19], [3,19], [2,19], [1,19], [0,19], [0,18], [0,17], [0,16], [0,15], [0,14], [0,13], [0,12], [0,11], [0,10], [0,9], [0,8], [0,7], [0,6], [0,5], [0,4], [0,3], [0,2], [0,1]}

}




object mapaNivel1 {
  var property image = "menoscargado-map1.png"
  method position() = game.origin()
  
}

object mapa{
  method mostrarMapaSegunNivel(nivel) {
    game.addVisual(nivel)
  }
}


object coordenadasBloqueadas {

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



  