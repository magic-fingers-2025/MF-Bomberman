import coordenadasBloqueadas.*
//import wollok.game.*

class Bomba{
  var property image = "3x-bomba-1.png"
  var property position
  var indiceAnimacionBomba = 0

    const animacionBomba = [
    "3x-bomba-1.png",
    "3x-bomba-2.png",
    "3x-bomba-3.png",
    "3x-bomba-1.png",
    "3x-bomba-2.png",
    "3x-bomba-3.png"
    
  ]

  
  const tick3 = game.tick(500,{self.cambiarImagenBomba()} , false)

  method iniciarCuentaRegresiva(){
    tick3.start()
  }

  method cambiarImagenBomba(){
    if (indiceAnimacionBomba< animacionBomba.size()){
      image = animacionBomba.get(indiceAnimacionBomba)
      indiceAnimacionBomba +=1
    }
    else{
      tick3.stop()
      //exploto = true 
      game.removeVisual(self)
      //explosion.explotar(self)  
      
      controladorDeExplosiones.crearExplosion(position)
  
            
    }  
  } 

  // polimorfismo onCollide con ella misma
  method morir(){}
/*
  const explosionVerticalMedio = object {
    const property image = "3x-explosion-vertical-medio-1.png"
    var property position = game.at(7,4)
  }



  const explosionVerticalArriba = object {
    const property image = "3x-explosion-vertical-arriba-1.png"
    var property position = game.at(5,5)
} 

  method explotar(){
    game.addVisual(explosionVerticalMedio)
    game.addVisual(explosionVerticalArriba)
    
  }
*/
}

object explosion {
  
}
object controladorDeExplosiones {

  method crearExplosion(posicionBomba) {

    self.crearParte(
      posicionBomba,
      "3x-explocion-centro-1.png"
    )

    self.propagarse(posicionBomba)
  }


  
  // CREA UNA PARTE DE EXPLOSIÓN 
  method crearParte(pos, imagen) {

    const parte = object {
      var property image = imagen
      var property position = pos
    }

    game.addVisual(parte)

    // matar al que toca
    game.onCollideDo(parte, { otro => otro.morir()})

    // remover en 3 segundos o lo que quieran
    game.schedule(3000, {
      game.removeVisual(parte)
    })
  }

    method propagarse(centro) {
    self.propagacionArriba(centro)
    self.propagacionAbajo(centro)
    self.propagacionIzquierda(centro)
    self.propagacionDerecha(centro)
  }

    method propagacionArriba(centro) {
    var x = centro.x()
    var y = centro.y()

    var pos1 = game.at(x, y + 1)
    if (not coordenadasBloqueadas.estaBloqueada(pos1)) {
      self.crearParte(pos1, "3x-explocion-vertical-etapa2-2.png")

      var pos2 = game.at(x, y + 2)
      if (not coordenadasBloqueadas.estaBloqueada(pos2)) {
        self.crearParte(pos2, "3x-explocion-vertical-etapa2-1.png")
      }
    }
  }

    method propagacionAbajo(centro) {
    var x = centro.x()
    var y = centro.y()

    var pos1 = game.at(x, y - 1)
    if (not coordenadasBloqueadas.estaBloqueada(pos1)) {
      self.crearParte(pos1, "3x-explocion-vertical-etapa2-2.png")

      var pos2 = game.at(x, y - 2)
      if (not coordenadasBloqueadas.estaBloqueada(pos2)) {
        self.crearParte(pos2, "3x-explocion-vertical-etapa2-3.png")
      }
    }
  }

    method propagacionIzquierda(centro) {
    var x = centro.x()
    var y = centro.y()

    var pos1 = game.at(x - 1, y)
    if (not coordenadasBloqueadas.estaBloqueada(pos1)) {
      self.crearParte(pos1, "3x-explosion-horizontal-estapa1-2.png")

      var pos2 = game.at(x - 2, y)
      if (not coordenadasBloqueadas.estaBloqueada(pos2)) {
        self.crearParte(pos2, "3x-explosion-horizontal-estapa1-1.png")
      }
    }
  }

    method propagacionDerecha(centro) {
    var x = centro.x()
    var y = centro.y()

    var pos1 = game.at(x + 1, y)
    if (not coordenadasBloqueadas.estaBloqueada(pos1)) {
      self.crearParte(pos1, "3x-explosion-horizontal-estapa1-2.png")

      var pos2 = game.at(x + 2, y)
      if (not coordenadasBloqueadas.estaBloqueada(pos2)) {
        self.crearParte(pos2, "3x-explosion-horizontal-estapa1-3.png")
      }
    }
  }


}




