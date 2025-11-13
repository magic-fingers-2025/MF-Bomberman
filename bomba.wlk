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
            
    }  
  } 

  // polimorfismo onCollide con ella misma
  method morir(){}

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

}





object explosion{
  var property position = game.origin()
  
  method image() = "" 

  method propagarseHaciaArriba(){
    //explosionVerticalMedio.position(position.y()+1)
    //explosionVerticalArriba.position(position.y()+2)
    //game.addVisual(explosionVerticalMedio)
    //game.addVisual(explosionVerticalArriba)
    //game.schedule(1000, {game.removeVisual(explosionVerticalArriba) } )
    //game.schedule(1000, {game.removeVisual(explosionVerticalMedio) } )
  }
  
  
}





