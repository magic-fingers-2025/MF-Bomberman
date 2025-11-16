import wollok.game.*

object sonido {
	method ejecutar(nombre) {
		if (!nombre.sonido().played()) {
			nombre.sonido().play()
			nombre.config()
		}
	}
	
	method detener(nombre) {
		nombre.sonido().stop()
	}
	
	method enEjecucion(nombre) = nombre.sonido().played()
}

object musicaInicio {
  const property sonido = game.sound("title-start.mp3")
	
	method config() {
		sonido.volume(0.3)
		sonido.shouldLoop(false)
	}
}

object musicNivel1 {
	const property sonido = game.sound("stage-theme.wav")
	
	method config() {
		sonido.volume(0.2)
		sonido.shouldLoop(true)
	}
}


