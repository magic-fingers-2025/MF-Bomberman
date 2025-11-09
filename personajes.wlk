import wollok.game.*
import fondo.*


object bomberman {
  var property image = "3x-paso-der-frente-bomberman.png"
  var property position = game.center()
  //var property sonidoCaminar = game.sound("player_run.mp3")

  method subir() {
    const nuevaPos = position.up(1)
    image = "3x-paso-der-espalda-bomberman.png"
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) ){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-espalda-bomberman.png"
    }
  }

  method bajar() {
    const nuevaPos = position.down(1)
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) ){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-frente-bomberman.png"
    }

  }

  method izquierda() {
    const nuevaPos = position.left(1)
    image = "3x-paso-izq-frente-bomberman.png"
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) ){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-perfil-izquierdo-bomberman.png"
    }
  }

  method derecha() {
    const nuevaPos = position.right(1)
    image = "3x-paso-der-frente-bomberman.png"
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) ){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-perfil-derecho-bomberman.png"
    }
  }

}





class Enemigo{
  var property image = "3x-enemigo-A-1.png"
  var property position
  var direccionActual = "Arriba"
  var indiceImagenActual = 0

  const imagenes= [
    "3x-enemigo-A-1.png",
    "3x-enemigo-A-3.png"
  ]
   

  method iniciarMovimiento(){
    if (direccionActual == "Arriba"){
      const tick = game.tick(500, { self.moverArribaSiSePuede() }, false)
      tick.start()
    }
    else if (direccionActual == "Derecha"){
      const tick = game.tick(500, { self.moverDerechaSiSePuede() }, false)
      tick.start()
    }
  
  }

  /*
  method moverVertical() {
  var direccionActual = "Arriba"

  if (direccionActual == "Arriba") {
    self.moverArribaSiSePuede()
    }
  else {
    direccionActual = "Abajo"
    self.moverAbajoSiSePuede()
  }
  
  }
  */

  method moverArribaSiSePuede() {
    const nuevaPos = position.up(1)
    
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and direccionActual == "Arriba"){
      position = nuevaPos
      image = imagenes.get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % imagenes.size()
    }
    else {
      direccionActual = "Abajo"
      self.moverAbajoSiSePuede()
    }
  }

  method moverAbajoSiSePuede() {
    
    const nuevaPos = position.down(1)
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and direccionActual == "Abajo"){
      position = nuevaPos
      image = imagenes.get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % imagenes.size()
    }
    else {
      direccionActual = "Arriba"
      self.moverArribaSiSePuede()
    }
  }

  method moverDerechaSiSePuede() {
    const nuevaPos = position.right(1)
    
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and direccionActual == "Derecha"){
      position = nuevaPos
      image = imagenes.get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % imagenes.size()
    }
    else {
      direccionActual = "Izquierda"
      self.moverIzquierdaSiSePuede()
    }
  }

  method moverIzquierdaSiSePuede() {
    const nuevaPos = position.left(1)
    
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and direccionActual == "Izquierda"){
      position = nuevaPos
      image = imagenes.get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % imagenes.size()
    }
    else {
      direccionActual = "Derecha"
      self.moverDerechaSiSePuede()
    }
  }

}



