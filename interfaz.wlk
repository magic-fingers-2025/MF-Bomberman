import wollok.game.*



object interfaz {
    var property vidasRestantes = 3
    var property puntaje = 0

    var vida1 = object { method position() = game.at(1, 0); method image() = "corazon.png" ; method id() = 1}
    var vida2 = object { method position() = game.at(2, 0); method image() = "corazon.png" ; method id() = 2}
    var vida3 = object { method position() = game.at(3, 0); method image() = "corazon.png" ; method id() = 3}

    const vidas = [vida1, vida2, vida3]


// todavia no andan los puntos porque no realizamos 
    var marcador = object {
        method position() = game.at(9, 0)
        method draw(g) {
            g.setColor("white")
            g.drawText("Puntaje: " + interfaz.puntaje, 0, 0)
        }
    }

    method mostrar() {
        game.addVisual(vida1)
        game.addVisual(vida2)
        game.addVisual(vida3)
        game.addVisual(marcador)
    }

  method perderUnaVida() {
    if (vidasRestantes > 0) {
      game.removeVisual(vidas.filter{v => v.id() == vidasRestantes})
      vidasRestantes = vidasRestantes - 1
    }
    else{     
      game.addVisual(gameOverPantalla) 
    }
  }

  method sumarPuntos(cantidad) {
      puntaje = puntaje + cantidad
  }


  method reiniciar() {
      vidasRestantes = 3
      puntaje = 0
  }
  const gameOverPantalla = object {
      method image() = "gameOver2.png"
      method position() = game.at(0.4, 0.4)
      method sonido() = "gameOver.mpeg" 
  }
}