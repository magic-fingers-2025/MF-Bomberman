import wollok.game.*



object interfaz {
    var property vidasRestantes = 3
    var property puntaje = 0

    var vida1 = object { method position() = game.at(1, 0); method image() = "corazon.png" }
    var vida2 = object { method position() = game.at(2, 0); method image() = "corazon.png" }
    var vida3 = object { method position() = game.at(3, 0); method image() = "corazon.png" }


// todavia no andan los puntos
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

    method actualizar() {
        game.removeVisual(vida1)
        game.removeVisual(vida2)
        game.removeVisual(vida3)
        if (vidasRestantes >= 1) game.addVisual(vida1)
        if (vidasRestantes >= 2) game.addVisual(vida2)
        if (vidasRestantes >= 3) game.addVisual(vida3)
    }

    method perderUnaVida() {
        vidasRestantes = vidasRestantes - 1
        self.actualizar()
        if (vidasRestantes == 0) {
            game.stop()
            game.addVisual(gameOverPantalla) 
        }
    }

    method sumarPuntos(cantidad) {
        puntaje = puntaje + cantidad
    }

    method reiniciar() {
        vidasRestantes = 3
        puntaje = 0
        self.actualizar()
    }
        const gameOverPantalla = object {
            method image() = "gameOver2.png"
            method position() = game.at(0.4, 0.4)
            method sonido() = "gameOver.mpeg" 
    }
}