import wollok.game.*
import bomberman.*
import menu.*


object interfaz {
    var property vidasRestantes = 3
    var property puntaje = 0
    var property nivel = 1

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

      game.removeVisual("menoscargado-map1.png")
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
  