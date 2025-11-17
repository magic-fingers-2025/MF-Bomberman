import wollok.game.*
import personajes.*
import sonidos.*
import imagenes.*
import interfaz.*
import bomba.*


object juego {
   

  method iniciar() {
    game.width(23)
    game.height(21)
    game.cellSize(48)
    game.title("Bomberman")
    //game.addVisual(pantallaInicio)
    game.start()
    //sonido.reproducir(musicaInicio)
    self.iniciarTeclado()
    interfaz.mostrarMenuInicio()
  }

  method iniciarTeclado(){
    
    keyboard.w().onPressDo{ bomberman.subir() }

    keyboard.s().onPressDo{ bomberman.bajar() }

    keyboard.a().onPressDo{ bomberman.izquierda() }

    keyboard.d().onPressDo{ bomberman.derecha() }

    keyboard.enter().onPressDo({
      interfaz.iniciarJuego()        
    
    })

    keyboard.space().onPressDo({bomberman.ponerBomba()})  // NO PONER DENTRO DEL keyboard.enter().onPressDo porque da un error tremendo si presionamos ENter dentro del juego 

  }
  
}

