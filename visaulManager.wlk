// fijarse de siempre agregar las visuales a la lista
// siempre reiniciar 


object visualManager{

    const visualesPuestas =[]
    const listaDeEnemigos = []

    //para agregar a la lista
    method agregarVisualALista(unaVisual){
      visualesPuestas.add(unaVisual)
    }

    method removerVisualesDeLista(){
      visualesPuestas.forEach({ v => game.removeVisual(v)})
    }

   method agregarEnemigoALista(unEnemigo){
      listaDeEnemigos.add(unEnemigo)
    }

    method removerEnemigoDeLista(unEnemigo){
      listaDeEnemigos.remove(unEnemigo)
    }


    method configTeclado() {
         keyboard.w().onPressDo{
    bomberman.subir()
  }

  keyboard.s().onPressDo{
    bomberman.bajar()
  }
  keyboard.a().onPressDo{
    bomberman.izquierda()
  }
  keyboard.d().onPressDo{
    bomberman.derecha()
  }

  keyboard.space().onPressDo({
      bomberman.ponerBombaConExplosion()
  })

    }

    method pantallaDeInicio() {
      // removemos primero todas las visuales 
      self.removerVisualesDeLista()
      listaDeEnemigos=[]

    const musicaInicio = game.sound("title-start.mp3")
    musicaInicio.play()
    menu.iniciar()


    
  // Iniciar juego con Enter
  keyboard.enter().onPressDo({
  
  interfaz.nivel(1)

  menu.cerrar()
  musicaInicio.stop()

 // personaje principal
  //evitar poner add visual characters para que no mal use las flechas
  game.addVisual(bomberman) 
  self.agregarVisualALista(bomberman)
// configuras a bomberman elteclado 
  self.configTeclado()

  const enemigoA = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
  game.addVisual(enemigoA)enemigoA
  self.agregarVisualALista(enemigoA)
  self.agregarEnemigoALista(enemigoA)
  //enemigoA.iniciarMovimiento()

  const enemigoB = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")
  //game.addVisual(enemigoB)
  self.agregarVisualALista(enemigoA)
  self.agregarEnemigoALista(enemigoB)
  //enemigoB.iniciarMovimiento()
  

  interfaz.mostrar()
  interfaz.reiniciar()

    }

  method gameOver(){
    game.addVisual(gameOverPantalla)
    self.agregarVisualALista(gameOverPantalla)
  }


  method nivel2(){
//poner la visual del nivel que corresponde
    / personaje principal
  //evitar poner add visual characters para que no mal use las flechas
  game.addVisual(bomberman) 
  self.agregarVisualALista(bomberman)
// configuras a bomberman elteclado 
  self.configTeclado()

  const enemigoA = new LLamaAzul(position = game.at(10,10), direccionActual = "Arriba")
  game.addVisual(enemigoA)enemigoA
  self.agregarVisualALista(enemigoA)
  self.agregarEnemigoALista(enemigoA)
  //enemigoA.iniciarMovimiento()

  const enemigoB = new LLamaAzul(position = game.at(15,7), direccionActual = "Derecha")
  //game.addVisual(enemigoB)
  self.agregarVisualALista(enemigoA)
  self.agregarEnemigoALista(enemigoB)
  //enemigoB.iniciarMovimiento()
  

  interfaz.mostrar()
  interfaz.reiniciar()

    }


  }

  method.evaluarSiPasaDeNivel() {
    if (listaDeEnemigos.selzide() == 0) {
      interfaz.nevel(2)

      self.nivel2()
    } else {}
    
  }

  method pantallaDeCreditos{
    game.addVisual(pantallaDeCreditos)
    self.agregarVisualALista(pantallaDeCreditos)
  }

  method evaluarSiGanaste(){
    if (interfaz.nivel() == 2 and listaDeEnemigos.selzide() == 0)
    game.addVisual(pantalleGanaste)
    self.agregarVisualALista(pantalleGanaste)
    game.schedule(3000, {self.pantallaDeCreditos()})
    game.schedule(8000,{self.pantallaDeInicio()})

  }


}