import rival.*
import wollok.game.*
import interfaz.*
import bomba.*

object personaje {
  var property position = game.at(3, 2)
  var property direccion = "frente"
  var property frameActual = 1
  var sonidoCaminar = game.sound("player_run.mp3")
  var property coordenadasBloqueadas = []
  
  method image() {
    if (direccion == "frente") {
      return "frente.png"
    } else {
      if (direccion == "izquierda") {
        if (frameActual == 1) {
          return "izquierda.png"
        } else {
          if (frameActual == 2) {
            return "caminaIzq1.png"
          } else {
            return "correizq.png"
          }
        }
      } else {
        if (direccion == "derecha") {
          return "derecha.png"
        } else {
          if (direccion == "arriba") {
            if (frameActual == 1) {
              return "Sube1.png"
            } else {
              if (frameActual == 2) {
                return "Sube2.png"
              } else {
                return "Sube3.png"
              }
            }
          } else {
            if (direccion == "abajo") {
              if (frameActual == 1) {
                return "Baja1.png"
              } else {
                if (frameActual == 2) {
                  return "Baja2.png"
                } else {
                  return "Baja3.png"
                }
              }
            } else {
              return "frente.png"
            }
          }
        }
      }
    }
  }
  
  method avanzarFrame() {
    frameActual += 1
    if (frameActual > 3) {
      frameActual = 1
    }
  }
  
  method moverseHaciaArriba() {
    direccion = "arriba"
    const nuevaPos = position.up(1)
    if (not self.estaBloqueada(nuevaPos.x(), nuevaPos.y())) {
      position = nuevaPos
      self.avanzarFrame()
      sonidoCaminar.play()
    }
  }
  
  method moverseHaciaAbajo() {
    direccion = "abajo"
    const nuevaPos = position.down(1)
    if (not self.estaBloqueada(nuevaPos.x(), nuevaPos.y())) {
      position = nuevaPos
      self.avanzarFrame()
      sonidoCaminar.play()
    }
  }
  
  method moverseHaciaDerecha() {
    direccion = "derecha"
    const nuevaPos = position.right(1)
    if (not self.estaBloqueada(nuevaPos.x(), nuevaPos.y())) {
      position = nuevaPos
      self.avanzarFrame()
      sonidoCaminar.play()
    }
  }
  
  method moverseHaciaIzquierda() {
    direccion = "izquierda"
    const nuevaPos = position.left(1)
    if (not self.estaBloqueada(nuevaPos.x(), nuevaPos.y())) {
      position = nuevaPos
      self.avanzarFrame()
      sonidoCaminar.play()
    }
  }
  
  method estaBloqueada(x, y) = coordenadasBloqueadas.any(
    { par => (par.get(0) == x) and (par.get(1) == y) }
  )
  
  method agregarMuros() {
    (0 .. (game.width() - 1)).forEach(
      { x => (1 .. (game.height() - 1)).forEach(
          { y =>
            if (((((x == 0) or (y == 1)) or (x == (game.width() - 1))) or (y == (game.height() - 1))) or (((x % 2) == 0) and ((y % 2) == 0))) {
              const muro = object {
                var property position = game.at(x, y)
                
                method image() = "muro.png"
              }
              game.addVisual(muro)
              coordenadasBloqueadas.add([x, y])
            } }
        ) }
    )
  }
  
  method chocarCon(rival) {
    throw new Exception(message = "ME ATRAPARON")
    interfaz.perderUnaVida()
    position = game.at(3, 2)
  }
  
  method colocarBomba() {
    const posActual = self.position()
    const bomba = new Bomba(
      posicion = posActual,
      posicionesProhibidas = coordenadasBloqueadas
    )
    game.addVisual(bomba)
    bomba.init()
    
    // bloquear la posición donde se coloca la bomba
    coordenadasBloqueadas.add([posActual.x(), posActual.y()])
    
    
    // intentar moverse a una celda libre vecina
    const posicionesVecinas = [
      posActual.up(1),
      posActual.down(1),
      posActual.left(1),
      posActual.right(1)
    ]
    
    var movido = false
    posicionesVecinas.forEach(
      { p => if ((not movido) and (not self.estaBloqueada(p.x(), p.y()))) {
          position = p
          movido = true
        } }
    )
  }
}