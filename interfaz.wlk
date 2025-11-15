import wollok.game.*
import bomberman.*
import menu.*


object interfaz {
    var property vidasRestantes = 3
    var property nivel = 1

    const vidas = self.iniciarVidas()

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

  method reiniciar() {

      game.removeVisual("menoscargado-map1.png")
      game.removeVisual(gameOverPantalla)
      self.vidasRestantes(3)
      self.actualizar()
      menu.iniciar()
      
  }

  method cambiarNivel(){

    // si no hay rivales en pantalla, pasar al siguiente- Hacemos que se cambie del 1 al 2 y asi
      if (nivel == 1) nivel = 2 else nivel = 1

  }

  
  const property gameOverPantalla = object {
      
      
  }

  method iniciarVidas(){
    var vida1 = object { method position() = game.at(1, 0); method image() = "corazon.png" ; method id() = 1}
    var vida2 = object { method position() = game.at(2, 0); method image() = "corazon.png" ; method id() = 2}
    var vida3 = object { method position() = game.at(3, 0); method image() = "corazon.png" ; method id() = 3}

    return [vida1, vida2, vida3]
    
  }

   method actualizar() {
        game.removeVisual(vidas.get(0))
        game.removeVisual(vidas.get(1))
        game.removeVisual(vidas.get(2))
        self.mostrar() // ESTO
    }

  }
  