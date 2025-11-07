import game.*

object posicionesProhibidas {

	var posicionesDeMuros = []
	var posicionesDeBloques = []
	var posicionesDeBombas = []

	method generarEstructuraDelMapa(game) {
		// Bordes
		(0..game.width() - 1).forEach { x =>
			self.agregarMuro(game.at(x, 0))
			self.agregarMuro(game.at(x, game.height() - 1))
		}
		(0..game.height() - 1).forEach { y =>
			self.agregarMuro(game.at(0, y))
			self.agregarMuro(game.at(game.width() - 1, y))
		}

		// Muros internos y bloques rompibles
		(1..game.width() - 2).forEach { x =>
			(1..game.height() - 2).forEach { y =>
				if (x % 2 == 0 and y % 2 == 0) {
					self.agregarMuro(game.at(x, y))
				} else if (1.randomUpTo(4) == 1) {
					self.agregarBloque(game.at(x, y))
				}
			}
		}
	}

	method agregarMuro(pos) {
		posicionesDeMuros.add(pos)
		game.addVisual(new Muro(position = pos))
	}

	method agregarBloque(pos) {
		posicionesDeBloques.add(pos)
		game.addVisual(new Bloque(position = pos))
	}

	method agregarBomba(pos) {
		posicionesDeBombas.add(pos)
	}

	method removerBomba(pos) {
		posicionesDeBombas.remove(pos)
	}

	method esProhibido(pos) =
		posicionesDeMuros.contains(pos)
		or posicionesDeBloques.contains(pos)
		or posicionesDeBombas.contains(pos)
}

object bomberman {

	var position = game.at(1, 1)
	var vidas = 3

	method moverA(nuevaPos) {
		if (not posicionesProhibidas.esProhibido(nuevaPos)) {
			self.position = nuevaPos
		}
	}

	method colocarBomba() {
		if (not posicionesProhibidas.posicionesDeBombas.contains(self.position)) {
			const bomba = new Bomba(position = self.position)
			game.addVisual(bomba)
			posicionesProhibidas.agregarBomba(self.position)
			game.onTick(2000, "explosion" + self.position.toString(), { bomba.explotar() })
		}
	}

	method chocarCon(enemigo) {
		vidas -= 1
		if (vidas <= 0) {
			game.over("💀 ¡Perdiste! Bomberman fue eliminado 💥")
		}
	}
}

class Enemigo {
	var numero
	var dificultad
	var position = game.randomPosition()

	method mover() {
		if (dificultad == "facil") self.moverRandom()
		else self.perseguir(bomberman)
	}

	method moverRandom() {
		const direcciones = [position.up(), position.down(), position.left(), position.right()]
		const nueva = direcciones.randomElement()
		if (not posicionesProhibidas.esProhibido(nueva)) position = nueva
	}

	method perseguir(objetivo) {
		const opciones = []
		if (objetivo.position.x() > position.x()) opciones.add(position.right())
		if (objetivo.position.x() < position.x()) opciones.add(position.left())
		if (objetivo.position.y() > position.y()) opciones.add(position.down())
		if (objetivo.position.y() < position.y()) opciones.add(position.up())

		const nueva = opciones.isEmpty() ? position : opciones.randomElement()
		if (not posicionesProhibidas.esProhibido(nueva)) position = nueva
	}
}

class Muro {
	var position
}

class Bloque {
	var position
	method romper() {
		game.removeVisual(self)
		posicionesProhibidas.posicionesDeBloques.remove(position)
	}
}

class Bomba {
	var position

	method explotar() {
		game.removeVisual(self)
		posicionesProhibidas.removerBomba(position)

		// Rango de la explosión (radio 1 en cruz)
		const posicionesAfectadas = [
			position,
			position.up(),
			position.down(),
			position.left(),
			position.right()
		]

		posicionesAfectadas.forEach { pos =>
			self.afectar(pos)
		}
	}

	method afectar(pos) {
		// Daña a bomberman
		if (pos == bomberman.position) {
			bomberman.vidas -= 1
			if (bomberman.vidas <= 0) game.over("💣 Bomberman explotó en mil pedazos 💥")
		}

		// Daña a enemigos
		game.visuals().forEach { visual =>
			if (visual isa Enemigo and visual.position == pos) {
				game.removeVisual(visual)
			}
		}

		// Rompe bloques
		game.visuals().forEach { visual =>
			if (visual isa Bloque and visual.position == pos) {
				visual.romper()
			}
		}
	}
}
