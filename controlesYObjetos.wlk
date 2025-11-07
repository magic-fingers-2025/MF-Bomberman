import wollok.game.*
/*
"--------------------------------------------"
"--------------- BOMBERMAN ------------------"
"--------------------------------------------"
*/
object bomberman {

	var property position = game.at(1, 1)
	var vidas = 3

	method moverA(nuevaPos) {
		if (not posicionesProhibidas.esProhibido(nuevaPos)) {
			position = nuevaPos
		}
	}

	method colocarBomba() {
		if (not posicionesProhibidas.posicionesDeBombas.contains(position)) {
			const bomba = new Bomba(position = position)
			game.addVisual(bomba)
			posicionesProhibidas.agregarBomba(position)

			game.onTick(3000, "explosion" + position.toString(), {
				bomba.explotar()
			})
		}
	}

	method recibirDanio() {
		vidas -= 1
		if (vidas <= 0) {
			game.over("💀 ¡Bomberman fue eliminado! 💥")
		} else {
			position = game.at(1, 1)
		}
	}
}
/*
"--------------------------------------------"
"----------- POSICIONES PROHIBIDAS -----------"
"--------------------------------------------"
*/
object posicionesProhibidas {
	var posicionesDeMuros = []
	var posicionesDeBombas = []

	method agregarMuro(pos) { posicionesDeMuros.add(pos) }
	method agregarBomba(pos) { posicionesDeBombas.add(pos) }
	method removerBomba(pos) { posicionesDeBombas.remove(pos) }

	method esProhibido(pos) =
		posicionesDeMuros.contains(pos) or posicionesDeBombas.contains(pos)
}
/*
"--------------------------------------------"
"------------------- MUROS ------------------"
"--------------------------------------------"
*/
class Muro {
	var property position
	init() { posicionesProhibidas.agregarMuro(position) }
}

class MuroRompible {
	var property position
	init() { posicionesProhibidas.agregarMuro(position) }

	method romper() {
		game.removeVisual(self)
		posicionesProhibidas.posicionesDeMuros.remove(position)
	}
}
/*
"--------------------------------------------"
"------------------- BOMBA ------------------"
"--------------------------------------------"
*/
class Bomba {
	var property position

	method explotar() {
		game.removeVisual(self)
		posicionesProhibidas.removerBomba(position)
		self.mostrarExplosion()

		const posicionesAfectadas = [
			position,
			position.up(),
			position.down(),
			position.left(),
			position.right()
		]

		posicionesAfectadas.forEach { pos => self.afectar(pos) }
	}

	method mostrarExplosion() {
		const explosion = new Explosion(position = position)
		game.addVisual(explosion)
		game.onTick(500, "borrarExplosion" + position.toString(), {
			game.removeVisual(explosion)
		})
	}

	method afectar(pos) {
		if (pos == bomberman.position) bomberman.recibirDanio()

		game.visuals().forEach { v =>
			if (v isa Enemigo and v.position == pos) game.removeVisual(v)
			if (v isa MuroRompible and v.position == pos) v.romper()
		}
	}
}
/*
"--------------------------------------------"
"----------------- EXPLOSION ----------------"
"--------------------------------------------"
*/
class Explosion {
	var property position
	init() {
		self.image = "explosion.png"
	}
}
/*
"--------------------------------------------"
"------------------ ENEMIGOS ----------------"
"--------------------------------------------"
*/
class Enemigo {
	var property position

	method moverFacil() {
		const posibles = [position.up(), position.down(), position.left(), position.right()]
		const nueva = posibles.randomElement()
		if (not posicionesProhibidas.esProhibido(nueva)) position = nueva
	}

	method moverDificil() {
		const opciones = []
		if (bomberman.position.x() > position.x()) opciones.add(position.right())
		if (bomberman.position.x() < position.x()) opciones.add(position.left())
		if (bomberman.position.y() > position.y()) opciones.add(position.down())
		if (bomberman.position.y() < position.y()) opciones.add(position.up())

		const nueva = opciones.isEmpty() ? position : opciones.randomElement()
		if (not posicionesProhibidas.esProhibido(nueva)) position = nueva
	}
}
