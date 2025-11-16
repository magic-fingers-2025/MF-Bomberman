import wollok.game.*
import bomberman.*
import menu.*
import controlador.*



object interfaz {
    var property vidasRestantes = 3
    var property puntaje = 0
    var property nivel = 1
    var property enemigosRestantes = 0
    const corazones = self.crearVidasVisuales()
    

    method morir(){}
    // pr las dudas 
    method nivel(n) { nivel = n }
    method nivel() = nivel

    method mostrar() {
      corazones.forEach({ c => if (not game.hasVisual(c)) game.addVisual(c) })

      // hasVisual cambia la vida de un programador
      /*
        game.addVisual(vidas.get(0))
        game.addVisual(vidas.get(1))
        game.addVisual(vidas.get(2))*/
    }

  method crearVidasVisuales(){
  var v1 = object { method image() = "corazon.png"; method position() = game.at(1,0); method id()=1; method morir(){} }
  var v2 = object { method image() = "corazon.png"; method position() = game.at(2,0); method id()=2; method morir(){} }
  var v3 = object { method image() = "corazon.png"; method position() = game.at(3,0); method id()=3; method morir(){} }
  return [v1,v2,v3]
  }

  method reiniciar() {

    // quitar visuales y volver a mostrar 3 vidas
    corazones.forEach({ c => if (game.hasVisual(c)) game.removeVisual(c) })
    vidasRestantes = 3
    self.mostrar()
      
  }

  method reiniciarVidas(){ vidasRestantes = 3 }

  
  method perderUnaVida() {
    
    if (vidasRestantes > 1) {
    game.removeVisual(corazones.get(vidasRestantes-1))
    vidasRestantes = vidasRestantes - 1
    } else {
    vidasRestantes = 0
    controlador.gameOver()
    }
  }
// si llega a andar todo lo otro
  method sumarPuntos(cantidad) {
      puntaje = puntaje + cantidad
  }

  method reiniciarContadorEnemigos(cantidad){ 
    enemigosRestantes = cantidad }
  
  method actualizarContadorEnemigos(cantidad){ 
    enemigosRestantes = cantidad }
  
  method actualizar(){}
  
  }
  
