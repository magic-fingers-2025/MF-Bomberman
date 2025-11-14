import interfaz.*
import coordenadasBloqueadas.*
import wollok.game.*
import fondo.*
import bomba.*


object bomberman {
  var property image = "3x-paso-der-frente-bomberman.png"
  var property position = game.center()
  //var property sonidoCaminar = game.sound("player_run.mp3")

  method subir() {
    const nuevaPos = position.up(1)
    image = "3x-paso-der-espalda-bomberman.png"
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-espalda-bomberman.png"
    }
  }

  method bajar() {
    const nuevaPos = position.down(1)
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-frente-bomberman.png"
    }

  }

  method izquierda() {
    const nuevaPos = position.left(1)
    image = "3x-paso-izq-frente-bomberman.png"
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-perfil-izquierdo-bomberman.png"
    }
  }

  method derecha() {
    const nuevaPos = position.right(1)
    image = "3x-paso-der-frente-bomberman.png"
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "3x-paso-der-perfil-derecho-bomberman.png"
    }
  }

  
  

  method ponerBombaConExplosion() {
    const nuevaBomba = new Bomba(position = position)   
    game.addVisual(nuevaBomba)
    
    nuevaBomba.iniciarCuentaRegresiva()
    nuevaBomba.explotar()
    
        
  }

  

  // polimorfismo para el onCollide de la bomba
  method morir() {
     interfaz.perderUnaVida()
  }

}



class Enemigo{
  var property image = "3x-enemigo-A-1.png"
  var property position
  var direccionActual = "Arriba"
  var indiceImagenActual = 0
  var indiceAnimacionMuerte = 0
  var property estaVivo = true
  
  method imagenes()

  
  const property animacionMuerteGeneral = [
    "3x-death-general-1.png",
    "3x-death-general-2.png",
    "3x-death-general-3.png",
    "3x-death-general-4.png",
    "3x-death-general-5.png",
    "3x-death-general-6.png",
    "3x-death-general-7.png",
    "3x-death-general-8.png"
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

 
  method moverArribaSiSePuede() {
    const nuevaPos = position.up(1)
    
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Arriba" and estaVivo){
      position = nuevaPos
      image = self.imagenes().get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % self.imagenes().size()
    }
    else if (estaVivo){
        direccionActual = "Abajo"
        self.moverAbajoSiSePuede()
      }
    else{self.morir()}
  }

  method moverAbajoSiSePuede() {
    
    const nuevaPos = position.down(1)
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Abajo" and estaVivo){
      position = nuevaPos
      image = self.imagenes().get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % self.imagenes().size()
    }
    else if (estaVivo) {      
      direccionActual = "Arriba"
      self.moverArribaSiSePuede()
    }  
    else{self.morir()}

  }

  method moverDerechaSiSePuede() {
    const nuevaPos = position.right(1)

    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Derecha" and estaVivo){
      position = nuevaPos
      image = self.imagenes().get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % self.imagenes().size()
    }
    else if (estaVivo){
      direccionActual = "Izquierda"
      self.moverIzquierdaSiSePuede()
    }
    else{self.morir()}

  }

  method moverIzquierdaSiSePuede() {
    const nuevaPos = position.left(1)
    
    if (not coordenadasBorde.coordenadas().contains([nuevaPos.x(), nuevaPos.y()]) and not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Izquierda"){
      position = nuevaPos
      image = self.imagenes().get(indiceImagenActual)
      indiceImagenActual = (indiceImagenActual + 1) % self.imagenes().size()
    }
    else if (estaVivo) {
      direccionActual = "Derecha"
      self.moverDerechaSiSePuede()
    }
    else {self.morir()}
  }


  method morir()

}


class LLamaAzul inherits Enemigo{
  const imagenes= [
    "3x-enemigo-A-1.png",
    "3x-enemigo-A-3.png"
  ]
  
  const animacionMuerte = [
    "3x-death-A-1.png",
    "3x-death-A-2.png"
  ] + animacionMuerteGeneral


  override method imagenes() = imagenes

  const tick2 = game.tick(100, { self.cambiarImagen() }, false)
  override method morir(){
    estaVivo = false    
    tick2.start()
  }

  method cambiarImagen(){
    if (indiceAnimacionMuerte < animacionMuerte.size()){
      image = animacionMuerte.get(indiceAnimacionMuerte)
      indiceAnimacionMuerte = indiceAnimacionMuerte + 1
    }
    else{
      tick2.stop() 
      game.removeVisual(self)
           
    }
  }

}



