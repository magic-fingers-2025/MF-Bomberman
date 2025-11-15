
import wollok.game.*
object menu {
  var property image = "inicio-bomberman.png"
  method position() = game.origin()
  
  // con esta hacemos visible la que este en el momento
  method iniciar() {
    game.addVisual(self)
    
  }

  method cerrar() {
    game.removeVisual(self)}

   method mostrarMapaSegunNivel(nivel) {
    // Quitar mapas previos
    // hay que ver que no de error al ejecutar
    game.removeVisual(fondoNivel1)
    game.removeVisual(fondoNivel2)

    if(nivel == 1) game.addVisual(fondoNivel1)
    else game.addVisual(fondoNivel2)
  }


  method fondoGanaste() {
    game.addVisual(pantallaGanaste)
  }
  
}
 
// —— BACKGROUNDS ——  
   object pantallaInicio{

    var property image = "inicio-bomberman.png"
    method position() = game.origin()
  }

   object fondoNivel1 {
    var property image = "menoscargado-map1.png"
    method position() = game.origin()
  }

  object fondoNivel2 {
    var property image = "map1-bomberman.png"
    method position() = game.origin()
  }

  object pantallaGanaste{
    var property image = "ganaste.png"
    method position() = game.origin()
  }

  object pantallaGameOver {
      var property image = "game-over.png"
      method position() = game.at(0.4, 0.4)
      method sonido() = "gameOver.mpeg"
  }

  object pantallaDeCreditos {
      var property image = "creditos.png"
      method position() = game.origin()
  }

  object pantallaPasasteANivel2 {

    /*   tenego que agregar bien la VISUAL ACAAAAAAAAA*/
      var property image = "creditos.png"
      method position() = game.origin()
  }


  
