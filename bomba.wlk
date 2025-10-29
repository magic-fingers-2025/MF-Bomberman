import wollok.game.*

object bombaFactory {
	method crearBomba(posicion, poder, game) = new Bomba(position = posicion, poder = poder, game = game)
}

class Bomba {
	const property position
	const property poder
	const property game

	method image() = "bomba.png"

	method explotar() {
		const posicionesExplosion = [
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

	method destruir() {
		game.removeVisual(self)
	}
}

class Explosion {
	const property position
	method image() = "explosion.png"
}