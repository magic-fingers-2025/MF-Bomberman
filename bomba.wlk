class Bomba{
  var property image = "3x-bomba-1.png"
  var property position
  var indiceAnimacionBomba = 0

  var property exploto = false


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
    }  
  }

}

object explosion{
  const explosion = [
    "explosion-1.png",
    "explosion-2.png",
    "explosion-3.png",
    "explosion-4.png",
    "explosion-5.png"
  ]

  const direcciones = ["Arriba","Abajo","Izquierda","Derecha"]

  method explotar(unaBomba){
    if (unaBomba.exploto() == true){
      direcciones.forEach({d => self.propagarseHacia(d)})
    }  
  }

  method propagarseHacia(direccion){
    
  }
}



