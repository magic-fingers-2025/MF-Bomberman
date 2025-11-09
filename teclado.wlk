import personaje.*
import menu.*
import juego.*

object configuracionTeclado {
    var teclado = tecladoJuego

    method modoMenu() { teclado = tecladoMenu }
    method modoJuego() { teclado = tecladoJuego }
}

class Teclado {
    method enter() {}
    method w() {}
    method s() {}
    method a() {}
    method d() {}
    method space() {}
}

object tecladoMenu inherits Teclado {
    override method enter() {
        game.removeVisual(menu)
        // Ejecutar iniciar juego (simulando el código de teclado enter)
    }
}

object tecladoJuego inherits Teclado {
    override method w() { personaje.moverseHaciaArriba() }
    override method s() { personaje.moverseHaciaAbajo() }
    override method a() { personaje.moverseHaciaIzquierda() }
    override method d() { personaje.moverseHaciaDerecha() }
    override method space() { personaje.colocarBomba() }
}
