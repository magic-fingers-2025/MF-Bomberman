import personajes.*
import wollok.game.*
import imagenes.*
import sonidos.*
import niveles.*



object interfaz {

  var property vidasRestantes = 3
  var esJuegoNuevo = true
  var property numeroDeNivel = 1
  var property nivelActual = nivel1
  var property sonidoActual = nivelActual.musicaDeFondo()  
  //var enemigosRestantes = nivelActual.cantidadDeEnemigos()
  var property enemigosActivos = #{} // enemigos vivos en pantalla
  var property visualesPuestas = #{pantallaInicio}

  method enemigosRestantes() = enemigosActivos.size()
  //method eliminarEnemigo(){
    //enemigosRestantes-= 1
  //}

  method agregarVisualAlStack(objeto){
    visualesPuestas.add(objeto)
  }

  method removerVisualesPuestas(){
    visualesPuestas.forEach({ v => if (game.hasVisual(v)) game.removeVisual(v) })
    visualesPuestas = #{}
  }
   // todo limpito
  method resetEstado(){
    self.removerVisualesPuestas()
    enemigosActivos = #{}
    numeroDeNivel = 1
    vidasRestantes = 3  
  }

  method mostrarMenuInicio(){
    game.addVisual(pantallaInicio)
    sonido.reproducir(musicaInicio)

  }

  method removerMenuInicio(){
    game.removeVisual(pantallaInicio)
    sonido.detener(musicaInicio)
  }

  method iniciarJuego() {
    // limpiar cualquier rastro
    self.resetEstado() 
    self.removerMenuInicio()
    //game.removeVisual(pantallaInicio)
    //sonido.detener(musicaInicio)    
    // comenzar nivel 1 con ENTER
    coordenadasBloqueadas.agregarBordes()
    self.iniciarNivel(1)    
  }   
  

  method iniciarNivel(n){
    // limpiar antes    
    self.removerVisualesPuestas()
    //nivelActual.desactivarMusicaDeFondo()
    numeroDeNivel = n
    //nivelActual = nivel1
    //nivelActual = niveles.listaDeNiveles().filter({n => n.id()==n}).anyOne()
    self.mostrarMapaSegunNivel(n)
    nivelActual.activarMusicaDeFondo()
    self.agregarVisualAlStack(nivelActual)
    coordenadasBloqueadas.agregarCoordenadas(nivelActual.coordenadasBloqueadas())
    //self.iniciarVidas()
    self.mostrarVidas() 
    game.addVisual(bomberman)
    self.agregarVisualAlStack(bomberman)
    self.crearEnemigosParaNivel(n)
    
  }
  
  method mostrarMapaSegunNivel(n){
    if (n==1){
      nivelActual = nivel1
      game.addVisual(nivel1)
      
    }
    else{
      game.addVisual(nivel2)
      self.nivelActual(nivel2)
    }  
    //game.addVisual(niveles.listaDeNiveles().filter{n => n.id()==n}.anyOne())    
    //nivelActual.activarEnemigos()
  }

  method iniciarVidas(){
    var vida1 = corazon1
    var vida2 = corazon2
    var vida3 = corazon3

    return [vida1, vida2, vida3]
    
  }

  method mostrarVidas() {
    const vidas = self.iniciarVidas()
    game.addVisual(vidas.get(0))
    game.addVisual(vidas.get(1))
    game.addVisual(vidas.get(2))
    self.agregarVisualAlStack(vidas.get(0))
    self.agregarVisualAlStack(vidas.get(1))
    self.agregarVisualAlStack(vidas.get(2))
  }

  method removerVidas() {
    const vidas = self.iniciarVidas()
    game.removeVisual(vidas.get(0))
    game.removeVisual(vidas.get(1))
    game.removeVisual(vidas.get(2))
    //self.mostrar() // ESTO
  }

  method perderUnaVida() {
    const vidas = self.iniciarVidas()
    if (vidasRestantes > 1) {
      game.removeVisual(vidas.filter{v => v.id() == vidasRestantes}.first())
      vidasRestantes = vidasRestantes - 1
    }
    else{     
      self.perder()
    }
  }

 

  method perder(){
    nivelActual.desactivarMusicaDeFondo()
    sonido.reproducir(musicaGameOver)
    vidasRestantes = 3
    self.removerVidas()
    self.removerVisuales()
    game.addVisual(gameOverPantalla)
    sonido.reproducir(musicaGameOver)   
    
    //sonidoActual = musicaGameOver
    game.schedule(12000, {self.volverAlMenu()})
    

  }

  /*
  method resetAndReturnToStart(){
  // limpiar todo y volver al inicio    
    self.resetEstado()
    self.iniciarJuego()
  }
  */

 

  method reiniciar(){
    
    //sonido.reproducir(musicaGanaste)
    
    //self.removerVidas()
    //self.removerVisuales()    
    //sonidoActual = musicaGameOver
    game.schedule(12000, {self.volverAlMenu()})
  }

  method removerVisuales() {
    game.removeVisual(nivelActual)
    game.removeVisual(bomberman)           
  }

  method volverAlMenu(){
    game.removeVisual(gameOverPantalla)
    self.mostrarMenuInicio()    
  }

  /*
  method cambiarNivel(){

    // si no hay rivales en pantalla, pasar al siguiente- Hacemos que se cambie del 1 al 2 y asi
      if (nivelActual == nivel1) nivelActual = nivel2 else nivelActual = nivel1

  }
  */

  method crearEnemigosParaNivel(n) {
    // ejemplo simple: nivel 1 -> 2 enemigos; nivel 2 -> 3 enemigos
    if (n == 1) {
    const e1 = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
    const e2 = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")
    self.agregarEnemigo(e1)
    self.agregarEnemigo(e2)
    }else {
    const e1 = new LLamaAzul(position = game.at(1,18), direccionActual = "Arriba")
    const e2 = new LLamaAzul(position = game.at(18,1), direccionActual = "Derecha")
    //const e3 = new LLamaAzul(position = game.at(12,12), direccionActual = "Arriba")
    self.agregarEnemigo(e1)
    self.agregarEnemigo(e2)
    //self.agregarEnemigo(e3)
  }
  }

  method agregarEnemigo(enemigo) {
    game.addVisual(enemigo)
    enemigosActivos.add(enemigo)
    self.agregarVisualAlStack(enemigo)
    enemigo.iniciarMovimiento()

  // COLISIÓN CON BOMBERMAN 
    game.onCollideDo(enemigo, { otro =>
      if (otro == bomberman) {
        bomberman.morir()
      }
    })

  // cuando un enemigo muere, debe avisar a la interfaz
  }
  
  method quitarEnemigo(enemigo) {
    enemigosActivos.remove(enemigo)
    //self.eliminarEnemigo()
    // si se acabaron los enemigos del nivel
    if (self.enemigosRestantes() == 0) {
        self.procesarFinDeNivel()
    }
  }

  method procesarFinDeNivel() {
    if (numeroDeNivel == 1) {
      numeroDeNivel = 2
      self.mostrarPasoANivel2()
    } 
    else if (numeroDeNivel == 2) {
      self.mostrarPantallaFinal()
    }
  }

  method mostrarPasoANivel2() {
    nivelActual.desactivarMusicaDeFondo()
    game.addVisual(pantallaPasasteANivel2)
    nivelActual = nivel2
    
    game.schedule(2000, { 
        game.removeVisual(pantallaPasasteANivel2) 
        self.iniciarNivel(2)
    })
  }


  method mostrarPantallaFinal() {    
    nivelActual.desactivarMusicaDeFondo()    
    self.removerVisualesPuestas()
    sonido.reproducir(musicaGanaste)
    game.addVisual(pantallaGanaste)

    game.schedule(5000, { 
        game.removeVisual(pantallaGanaste)
        game.addVisual(pantallaCreditos) 
    })

    game.schedule(10000, { 
        game.removeVisual(pantallaCreditos)        
        self.mostrarMenuInicio()
    })
  }

  

 
  
}








