import wollok.game.*

// ===================================================
// 🔒 POSICIONES PROHIBIDAS
// ===================================================
object posicionesProhibidas {
	var posicionesMuros = []
	var posicionesBombas = []
	var posicionesBordes = []

	method inicializar(game) {
		self.definirBordes(game)
		self.definirMurosInternos(game)
	}

	method definirBordes(game) {
		(0..game.width() - 1).forEach { x =>
			posicionesBordes.add(game.at(x, 0))
			posicionesBordes.add(game.at(x, game.height() - 1))
		}
		(0..game.height() - 1).forEach { y =>
			posicionesBordes.add(game.at(0, y))
			posicionesBordes.add(game.at(game.width() - 1, y))
		}
	}

	method definirMurosInternos(game) {
		(1..game.width() - 2).forEach { x =>
			(1..game.height() - 2).forEach { y =>
				if (x % 2 == 0 and y % 2 == 0) {
					posicionesMuros.add(game.at(x, y))
				}
			}
		}
	}

	method agregarBomba(pos) { posicionesBombas.add(pos) }
	method quitarBomba(pos) { posicionesBombas.remove(pos) }

	method esProhibida(pos) =
		posicionesMuros.contains(pos)
		or posicionesBordes.contains(pos)
		or posicionesBombas.contains(pos)
}

// ===================================================
// 🧭 CLASE MOVIMIENTO
// ===================================================
class Movimiento {
	var property position
	const property game

	method moverA(posNueva) {
		if (not posicionesProhibidas.esProhibida(posNueva)) {
			position = posNueva
		}
	}
}

// ===================================================
// 💣 BOMBAS Y EXPLOSIONES
// ===================================================
object bombaFactory {
	method crearBomba(pos, poder, game) {
		posicionesProhibidas.agregarBomba(pos)
		const bomba = new Bomba(position = pos, poder = poder, game = game)
		game.addVisual(bomba)
		game.schedule(2000, { bomba.explotar() })
	}
}

class Bomba {
	const property position
	const property poder
	const property game

	method image() = "bomba.png"

	method explotar() {
		posicionesProhibidas.quitarBomba(position)
		const posicionesExplosion = [
			position,
			position.up(poder),
			position.down(poder),
			position.left(poder),
			position.right(poder)
		]
		posicionesExplosion.forEach { pos =>
			game.addVisual(new Explosion(position = pos))
		}
		game.schedule(500, { self.destruir() })
	}

	method destruir() { game.removeVisual(self) }
}

class Explosion {
	const property position
	method image() = "explosion.png"
}

// ===================================================
// 🧍‍♂️ BOMBERMAN (jugador principal)
// ===================================================
class Bomberman inherits Movimiento {
	var property poder = 1
	method image() = "bomberman.png"
	method colocarBomba() { bombaFactory.crearBomba(position, poder, game) }
}

// ===================================================
// 👾 ENEMIGOS
// ===================================================
class Enemigo inherits Movimiento {
	const property numero
	method image() = "rival" + numero.toString() + ".png"

	method moverAleatorio() {
		const movimientos = [position.up(), position.down(), position.left(), position.right()]
		self.moverA(movimientos.randomElement())
	}
}
