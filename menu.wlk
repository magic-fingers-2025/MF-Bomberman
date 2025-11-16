
import wollok.game.*
object menu {

  method morir(){}
  var property image = "inicio-bomberman.png"
  method position() = game.origin()

  // visuales como objetos con image() y position()
const property pantallaInicio = object { 
  method image() = "inicio-bomberman.png"
  method position() = game.origin()
  method morir(){} }
const property fondoNivel1 = object { 
  method image() = "map1-bomberman.png"
  method position() = game.origin()
  method morir(){} }
const property fondoNivel2 = object { 
  method image() = "map2-bomberman.png" 
  method position() = game.origin() 
  method morir(){} }
const property pantallaPasasteANivel2 = object { 
  method image() = "complete-lvl1.png" 
  method position() = game.origin() 
  method morir(){} }
const property pantallaGanaste = object { 
  method image() = "ganaste.png" 
  method position() = game.origin() 
  method morir(){} }
const property pantallaCreditos = object { 
  method image() = "creditos.png" 
  method position() = game.origin() 
  method morir(){} }
const property pantallaGameOver = object { 
  method image() = "game-over.png" 
  method position() = game.at(0.4,0.4) 
  method morir(){} }
  
  
  // con esta hacemos visible la que este en el momento
  method iniciar() {
    game.addVisual(pantallaInicio)
  }

  method cerrar() {
    if (game.hasVisual(pantallaInicio)) game.removeVisual(pantallaInicio)
    }

  method mostrarPantallaInicio(){ 
    if (not game.hasVisual(pantallaInicio)){
    game.addVisual(pantallaInicio) }
    }

   method mostrarMapaSegunNivel(n){ 
    game.removeVisual(fondoNivel1) 
    game.removeVisual(fondoNivel2) 
    if (n == 1){ game.addVisual(fondoNivel1)} 
    else {
        game.addVisual(fondoNivel2) }
   }

  method fondoGanaste() {
    game.addVisual(pantallaGanaste)
  }
  
}
 /*
// —— BACKGROUNDS ——  

se queja asi no puedo usar los nombre como constantes 
   object pantallaInicio{
    method morir() {}
    var property image = "inicio-bomberman.png"
    method position() = game.origin()
  }

   object fondoNivel1 {
    method morir() {}
    var property image = "map1-bomberman.png"
    method position() = game.origin()
  }

  object pantallaPasasteANivel2 {
    method morir() {}
    var property image = "complete-lvl1.png"
    method position() = game.origin()
  }

  object fondoNivel2 {
    method morir() {}
    var property image = "map2-bomberman.png"
    method position() = game.origin()
  }

  object pantallaGanaste{
    method morir() {}
    var property image = "ganaste.png"
    method position() = game.origin()
  }


  object pantallaCreditos{
    method morir() {}
    var property image = "creditos.png"
    method position() = game.origin()
  }

  object pantallaGameOver { 
    method image() = "game-over.png"
    method position() = game.at(0.4,0.4) 
    method morir(){} }

*/

  
