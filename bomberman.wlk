import bomba.*

object bomberman {
	const property image = "bomberman.png"
	var property position = game.origin()
/*
  method colocarBomba() {
	const bomba = bombaFactory.crearBomba(position, poder, game)
		game.addVisual(bomba)
		game.schedule(2000, { bomba.explotar() })
	}
*/
}

class Rival {
	const numero = 1
	var property position = game.at(3, 3)
	var previousPosition = position

	method image() = "rival" + numero.toString() + ".png"

	method acercarseA(personaje) {
		const otroPosicion = personaje.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
     
		// evitamos que se posicionen fuera del tablero
		newX = newX.max(0).min(game.width() - 1)
		newY = newY.max(0).min(game.height() - 1)
		previousPosition = position
		position = game.at(newX, newY)
	}
	
	method resetPosition() {
		position = game.at(numero + 1, numero + 1)
	}
	
	method chocarCon(otro) {
		self.resetPreviousPosition()
	}
	
	method resetPreviousPosition() {
		position = previousPosition 
	}
}