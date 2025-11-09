import wollok.game.*
import personaje.*

class Rival {
    var property numero
    var property position
    method image() = "rival1.png"

    method iniciarMovimientoAutomatico(personaje) {
        const intervalo = (1.randomUpTo(3) * 300)
        game.schedule(intervalo, {
            self.moverAleatorioSiLibre(personaje)
            self.iniciarMovimientoAutomatico(personaje)
        })
    }

    method moverAleatorioSiLibre(personaje) {
        const direccion = [position.up(1), position.down(1), position.left(1), position.right(1)].anyOne()
        if (not personaje.estaBloqueada(direccion.x(), direccion.y())) {
            position = direccion
        }
    }
}

const rivales = [
    new Rival(numero = 1, position = game.at(11, 9)),
    new Rival(numero = 2, position = game.at(9, 3))
]
