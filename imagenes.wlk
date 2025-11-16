import wollok.game.*
import interfaz.*

class Imagen {
  var property position = game.at(0, 0)
  const imagen
  
  method image() = imagen
  
  method position() = position
}

const menu = new Imagen(imagen = "inicio-bomberman.png")

const nivel1 = new Imagen(imagen = "menoscargado-map1.png")

const ganaste = new Imagen(imagen = "ganaste.png")

//const perdiste = new Imagen(imagen = "pantallaPerdiste.jpg")


const corazon1 = new Imagen(
  imagen = "corazon.png",
  position = game.at(1, 0)
)

const corazon2 = new Imagen(
  imagen = "corazon.png",
  position = game.at(2, 0)
)

const corazon3 = new Imagen(
  imagen = "corazon.png",
  position = game.at(3, 0)
)

const pasoDerechaFrente = new Imagen(
  imagen = "3x-paso-der-frente-bomberman.png"  
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