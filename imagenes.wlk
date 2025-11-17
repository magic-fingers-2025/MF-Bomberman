import wollok.game.*
import interfaz.*

class Imagen {
  var property position = game.at(0, 0)
  const imagen  
  method image() = imagen  
  method position() = position
  const property id  = 1
}

//const menu = new Imagen(imagen = "inicio-bomberman.png")

const ganaste = new Imagen(imagen = "ganaste.png")

//const perdiste = new Imagen(imagen = "pantallaPerdiste.jpg")

const pantallaInicio = new Imagen(
  imagen = "inicio-bomberman.png",
  position = game.at(0, 0)
  
)

const pantallaPasasteANivel2 = new Imagen(
  imagen = "complete-lvl1.png",
  position = game.at(0, 0)
  
)

const pantallaGanaste = new Imagen(
  imagen = "ganaste.png",
  position = game.at(0, 0)
  
)

const pantallaCreditos = new Imagen(
  imagen = "creditos.png",
  position = game.at(0, 0)
  
)

const corazon1 = new Imagen(
  imagen = "corazon.png",
  position = game.at(1, 0),
  id = 1
)

const corazon2 = new Imagen(
  imagen = "corazon.png",
  position = game.at(2, 0),
  id = 2
)

const corazon3 = new Imagen(
  imagen = "corazon.png",
  position = game.at(3, 0),
  id = 3
)

const gameOverPantalla = new Imagen(
  imagen = "game-over.png",
  position = game.at(0, 0)
)



/*
class Cursor inherits Imagen {
  var property letraActual = 0
  const letraMin = 0
  const letraMax = 2
  
  method mostraryOcultar() {
    if (not game.hasVisual(self)) game.addVisual(self)
    game.schedule(500, { self.ocultar() })
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
  }
  
  method titilar() {
    game.onTick(500, "cursor", { self.mostraryOcultar() })
  }
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
  
  method aumentarLetra() {
    const letraAux = letraActual + 1
    letraActual = if (letraAux.between(letraMin, letraMax)) letraAux
                  else self.restablecer(letraAux)
  }
  
  method disminuirLetra() {
    const letraAux = letraActual - 1
    letraActual = if (letraAux.between(letraMin, letraMax)) letraAux
                  else self.restablecer(letraAux)
  }
  
  method restablecer(unaLetra) = if (unaLetra < letraMin) letraMax else letraMin
  
  method reiniciar() {
    letraActual = 0
  }
}

const objCursor = new Cursor(
  imagen = "cursor.png",
  position = game.at(interfaz.ubicacionLetras().get(0), 4.5)
)
*/