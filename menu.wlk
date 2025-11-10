
import wollok.game.*
object menu {
  const property image = "fondoMF.png"
  method position() = game.origin()
  const musicaInicio = game.sound("title-start.mp3")
  
  method iniciar() {
    game.addVisual(self)
    musicaInicio.play()
  }

  method cerrar() {
    game.removeVisual(self)
    musicaInicio.stop()
  }
  const letrasInicio = [
    "x-C.png",
    "x-0.png",
    "x-M.png",
    "x-E.png",
    "x-N.png",
    "x-Z.png",
    "x-A.png",
    "x-R.png"
  ]

  const posicionesLetras = [[8, 5], [10, 5], [12,5], [14,5], [16,5], [18,5], [20,5]]
  var indiceLetra = 0
  method mensajeInicio(){    
    posicionesLetras.forEach({pos =>
      const letraAPoner = object {
      const property position = game.at(pos.get(0), pos.get(1)) 
      var property image = letrasInicio.get(indiceLetra)
      
      }
      game.addVisual(letraAPoner)
      indiceLetra += 1
  })
  }
}