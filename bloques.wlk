class Bloque {
	const property position
	method image() = "bloque.png"
	method esRompible() = true
}

class Muro {
	const property position
	method image() = "muro.png"
	method esRompible() = false
}
