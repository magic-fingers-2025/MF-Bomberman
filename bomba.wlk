import wollok.game.*

class Bomba {
  const property posicion
  const property posicionesProhibidas
  const property rango = 2
  var property position = posicion
  var property activa = true

  // ==========================
  // IMAGEN SEGÚN ESTADO
  // ==========================
  method image() = if (activa) "bombaInicial.png" else "bombaExplotada.png"

  // ==========================
  // AL COLOCARSE
  // ==========================
  method init() {
    game.schedule(3000, { self.explotar() })
  }

  // ==========================
  // EXPLOSIÓN PRINCIPAL
  // ==========================
  method explotar() {
    if (activa) {
      activa = false

      // quitar la bomba del mapa de bloqueos
      posicionesProhibidas.removeIf { p =>
        p.get(0) == posicion.x() and p.get(1) == posicion.y()
      }

      // imagen central de explosión
      const centro = object {
        const position = self.posicion()
        method image() = "bombaExplotada.png"
      }

      game.addVisual(centro)
      game.removeVisual(self)

      // propagar en 4 direcciones
      self.expandirEnDireccion("arriba")
      self.expandirEnDireccion("abajo")
      self.expandirEnDireccion("izquierda")
      self.expandirEnDireccion("derecha")

      // quitar el fuego central después de un tiempo
      game.schedule(600, { game.removeVisual(centro) })
    }
  }

  // ==========================
  // PROPAGACIÓN DE FUEGO
  // ==========================
  method expandirEnDireccion(direccion) {
    var pos = self.posicion()
    var cortar = false

    (1..rango).forEach { paso =>
      if (not cortar) {
        const nuevaPos = self.avanzar(pos, direccion)
        const prohibida = posicionesProhibidas.any { p =>
          p.get(0) == nuevaPos.x() and p.get(1) == nuevaPos.y()
        }

        if (not prohibida) {
          const fuego = object {
            const position = game.at(nuevaPos.x(), nuevaPos.y())
            method image() = "fuego.png"
          }

          game.addVisual(fuego)
          game.schedule(600, { game.removeVisual(fuego) })
          pos = nuevaPos
        } else {
          cortar = true
        }
      }
    }
  }

  // ==========================
  // AVANZAR EN DIRECCIÓN
  // ==========================
  method avanzar(pos, direccion) =
    if (direccion == "arriba") game.at(pos.x(), pos.y() - 1)
    else if (direccion == "abajo") game.at(pos.x(), pos.y() + 1)
    else if (direccion == "izquierda") game.at(pos.x() - 1, pos.y())
    else if (direccion == "derecha") game.at(pos.x() + 1, pos.y())
    else pos
}
