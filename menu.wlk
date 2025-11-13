
import wollok.game.*
object menu {
  const property image = "inicio-bomberman.png"
  method position() = game.origin()
  
  
  method iniciar() {
    game.addVisual(self)
    
  }

  method cerrar() {
    game.removeVisual(self)
    
  }
}