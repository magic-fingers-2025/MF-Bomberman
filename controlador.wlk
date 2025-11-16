import wollok.game.*
import personajes.*
import fondo.*
import bomba.*
import menu.*
import interfaz.*
import coordenadasBloqueadas.*


object controlador {

var property nivelActual = 1
var property enemigosActivos = #{} // conjunto de enemigos vivos en pantalla
var property visualesPuestas = #{} // para poder limpiar


method iniciarJuego() {
// limpiar cualquier rastro
self.resetEstado()
menu.iniciar()
// tecla i para parar el juego (extra)

//keyboard.i().onPressDo({ game.stop() })


self.pantallaInicio()
}


method resetEstado(){
enemigosActivos = #{}
visualesPuestas = #{}
nivelActual = 1
interfaz.reiniciar()
}


method pantallaInicio(){
self.removerVisualesPuestas()
menu.mostrarPantallaInicio()


// comenzar nivel 1 con ENTER
keyboard.enter().onPressDo({
if (game.hasVisual(menu.pantallaInicio())){
game.removeVisual(menu.pantallaInicio())}

self.iniciarNivel(1)

})
}


method iniciarNivel(n) {
// limpiar antes
self.removerVisualesPuestas()
nivelActual = n
interfaz.nivel(n)


// cargar fondo y coordenadas
menu.mostrarMapaSegunNivel(n)
coordenadasBloqueadas.reset()
coordenadasBloqueadas.bordes()
if (n == 1) coordenadasBloqueadas.nivel1() else coordenadasBloqueadas.nivel2()


// colocar bomberman en su posición inicial
bomberman.position(game.at(1,1))
if (not game.hasVisual(bomberman)) {
    game.addVisual(bomberman)
    self.agregarVisualPuesta(bomberman)
    

// configurar teclado
    self.configTeclado()}


// crear enemigos segun nivel y registrarlos
self.crearEnemigosParaNivel(n)


// mostrar interfaz
if (not game.hasVisual(interfaz)) {
// interfaz es un objeto con visuales (corazones)
}
interfaz.mostrar()
interfaz.reiniciarContadorEnemigos(enemigosActivos.size())
}


method crearEnemigosParaNivel(n) {
// ejemplo simple: nivel 1 -> 2 enemigos; nivel 2 -> 3 enemigos
if (n == 1) {
const e1 = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
const e2 = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")
self.agregarEnemigo(e1)
self.agregarEnemigo(e2)
}else {
const e1 = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
const e2 = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")
const e3 = new LLamaAzul(position = game.at(12,12), direccionActual = "Arriba")
self.agregarEnemigo(e1)
self.agregarEnemigo(e2)
self.agregarEnemigo(e3)
}
}

method agregarEnemigo(enemigo) {
game.addVisual(enemigo)
enemigosActivos.add(enemigo)
self.agregarVisualPuesta(enemigo)
enemigo.iniciarMovimiento()

// cuando un enemigo muere, debe avisar al controlador
}
method quitarEnemigo(enemigo) {
    enemigosActivos.remove(enemigo)
    interfaz.actualizarContadorEnemigos(enemigosActivos.size())

    // si se acabaron los enemigos del nivel
    if (enemigosActivos.size() == 0) {
        self.procesarFinDeNivel()
    }
}

method procesarFinDeNivel() {
    if (nivelActual == 1) {
        self.mostrarPasoANivel2()
    } 
    else if (nivelActual == 2) {
        self.mostrarPantallaFinal()
    }
}

method mostrarPasoANivel2() {
    game.addVisual(menu.pantallaPasasteANivel2())
    game.schedule(2000, { 
        game.removeVisual(menu.pantallaPasasteANivel2()) 
        self.iniciarNivel(2)
    })
}

method mostrarPantallaFinal() {
    game.addVisual(menu.pantallaGanaste())

    game.schedule(5000, { 
        game.removeVisual(menu.pantallaGanaste())
        game.addVisual(menu.pantallaCreditos()) 
    })

    game.schedule(10000, { 
        game.removeVisual(menu.pantallaCreditos())
        self.resetAndReturnToStart()
    })
}


method resetAndReturnToStart(){
// limpiar todo y volver al inicio
self.removerVisualesPuestas()
self.resetEstado()
menu.iniciar()
}


method agregarVisualPuesta(v){ visualesPuestas.add(v) }


method removerVisualesPuestas(){
visualesPuestas.forEach({ v => if (game.hasVisual(v)) game.removeVisual(v) })
visualesPuestas = #{}
}


method configTeclado(){
keyboard.w().onPressDo{ bomberman.subir() }
keyboard.s().onPressDo{ bomberman.bajar() }
keyboard.a().onPressDo{ bomberman.izquierda() }
keyboard.d().onPressDo{ bomberman.derecha() }
keyboard.space().onPressDo({ bomberman.ponerBombaConExplosion() })
}


method gameOver(){
// mostrar pantalla game over, luego reset
game.addVisual(menu.pantallaGameOver())
game.schedule(3000, { game.removeVisual(menu.pantallaGameOver()) self.resetAndReturnToStart() })
}
}

