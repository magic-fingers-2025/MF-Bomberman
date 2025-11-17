import wollok.game.*

object sonido {
	method reproducir(nombre) {
    if (!nombre.pista().played()){
      nombre.config()
			nombre.pista().play()
			
    }
	}
	
	method detener(nombre) {
		nombre.pista().stop()
	}
	
	method enEjecucion(nombre) = nombre.pista().played()
}

object musicaInicio {
  const property pista = game.sound("title-start.mp3")
	
	method config() {
		pista.volume(0.5)
		pista.shouldLoop(false)
	}
}

object musicaNivel1 {
	const property pista = game.sound("stage-theme.wav")
	
	method config() {
		pista.volume(0.5)
		pista.shouldLoop(true)
	}
}
object musicaNivel2 {
	const property pista = game.sound("nivel2-tema.wav")
	
	method config() {
		pista.volume(0.4)
		pista.shouldLoop(true)
	}
}

object musicaGameOver{
  const property pista = game.sound("game-over.mp3")
	
	method config() {
		pista.volume(0.5)
		pista.shouldLoop(false)
	}
}

object musicaGanaste{
  const property pista = game.sound("victory.mp3")
	
	method config() {
		pista.volume(0.5)
		pista.shouldLoop(false)
	}
}

object explosion{
  const property pista = game.sound("BOM_11_L.wav")
	
	method config() {
		pista.volume(0.8)
		pista.shouldLoop(false)
	}
}

object silencio{
  const property pista = game.sound("stage-theme.wav")
  method config() {
		pista.volume(0.5)
		pista.shouldLoop(true)
	}
}



