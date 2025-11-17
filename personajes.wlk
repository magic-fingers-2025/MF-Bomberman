import interfaz.*
import wollok.game.*
import imagenes.*
import bomba.*
import niveles.*


object bomberman {
  var property image = "bomberman-paso-der-frente.png"
  var property position = game.origin()
  //var property sonidoCaminar = game.sound("player_run.mp3")

  method subir() {
    const nuevaPos = position.up(1)
    if (not coordenadasBloqueadas.estaBloqueada(nuevaPos) and not interfaz.visualesPuestas().contains(pantallaInicio)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "bomberman-paso-der-espalda.png"
    }
  }

  method bajar() {
    const nuevaPos = position.down(1)
    if (not coordenadasBloqueadas.estaBloqueada(nuevaPos) and not interfaz.visualesPuestas().contains(pantallaInicio)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "bomberman-paso-der-frente.png"
    }

  }

  method izquierda() {
    const nuevaPos = position.left(1)
    if ( not coordenadasBloqueadas.estaBloqueada(nuevaPos) and not interfaz.visualesPuestas().contains(pantallaInicio)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "bomberman-paso-der-perfil-izquierdo.png"
    }
  }

  method derecha() {
    const nuevaPos = position.right(1)
    if ( not coordenadasBloqueadas.estaBloqueada(nuevaPos) and not interfaz.visualesPuestas().contains(pantallaInicio)){
      position = nuevaPos
      game.sound("PLAYER_WALK.wav").play()
      image = "bomberman-paso-der-perfil-derecho.png"
    }
  }

  
  

  method ponerBomba() {
    const nuevaBomba = new Bomba(position = position)   
    if (not interfaz.visualesPuestas().contains(pantallaInicio)){
      game.addVisual(nuevaBomba)  
      nuevaBomba.iniciarCuentaRegresiva()
    }
  }

  

  // polimorfismo para el onCollide de la bomba
  method morir() {
     interfaz.perderUnaVida()
     position = game.at(1,1)
  }

}



class Enemigo{
  var property image = "enemigo-A-1.png"
  var property position
  var direccionActual = "Arriba"
  var indiceImagenActual = 0
  var indiceAnimacionMuerte = 0
  var property estaVivo = true
  
  method imagenes()

  
  const property animacionMuerteGeneral = [
    "death-general-1.png",
    "death-general-2.png",
    "death-general-3.png",
    "death-general-4.png",
    "death-general-5.png",
    "death-general-6.png",
    "death-general-7.png",
    "death-general-8.png"
  ]
    
  const tickEnemigoArriba = game.tick(500, { self.moverArribaSiSePuede() }, false)
  const tickEnemigoDerecha = game.tick(500, { self.moverDerechaSiSePuede() }, false)
      
  method iniciarMovimiento(){
    if (direccionActual == "Arriba"){     
      tickEnemigoArriba.start()
    }
    else if (direccionActual == "Derecha"){
      tickEnemigoDerecha.start()
    }
  
  }

  method detenerMovimiento(){
    tickEnemigoArriba.stop()
    tickEnemigoDerecha.stop()
  }

 
  method moverArribaSiSePuede() {
    const nuevaPos = position.up(1)
    
    if (not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Arriba" and estaVivo){
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
    if (not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Abajo" and estaVivo){
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

    if (not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Derecha" and estaVivo){
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
    
    if (not coordenadasBloqueadas.estaBloqueada(nuevaPos) and direccionActual == "Izquierda"){
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
    "enemigo-A-1.png",
    "enemigo-A-3.png"
  ]
  
  const animacionMuerte = [
    "death-A-1.png",
    "death-A-2.png"
  ] + animacionMuerteGeneral


  override method imagenes() = imagenes

  const tick2 = game.tick(250, { self.animarMuerte() }, false)
  
  method animarMuerte(){
    if (indiceAnimacionMuerte < animacionMuerte.size()){
      image = animacionMuerte.get(indiceAnimacionMuerte)
      indiceAnimacionMuerte = indiceAnimacionMuerte + 1
    }
    else{
      tick2.stop()            
    }
  }

  override method morir(){      
    tick2.start()
    interfaz.quitarEnemigo(self)
    self.detenerMovimiento()
    game.removeVisual(self)
    
  }

  
 

}



