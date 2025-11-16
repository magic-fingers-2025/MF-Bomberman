import wollok.game.*
import coordenadasBloqueadas.*


class Muro {
  var position = game.at(0,0)
  var property image  = "3x-borde-sur-1-roca.png"
  
  
}


class MuroBorde inherits Muro {
  var tipo = bloqueSur
    
  // Por qué tuvimos que poner - 2 y no -1
  method concatenarMurosHorizontalesSegunTipo(){
    (1..game.width() - 2).forEach({ x =>
        tipo.asignarImagenSegunCoordenadaX(x)                
        const muroAPoner = object {
          const property position = game.at(x, tipo.coordenadaFija())
          var property image = tipo.image()
        }
        // Si no ponía property a la position de muroAPoner recibía un error de addVisual "positionable lacks a position". Por qué???
        game.addVisual(muroAPoner)
      }) 
  }

  method concatenarMurosVerticaleslesSegunTipo(){
    (1..game.height() - 2).forEach({ y =>
        tipo.asignarImagenSegunCoordenadaY(y)                
        const muroAPoner = object {
          const property position = game.at(tipo.coordenadaFija(), y)
          var property image = tipo.image()
        }
        // Si no ponía property a la position de muroAPoner recibía un error de addVisual "positionable lacks a position". Por qué???
        game.addVisual(muroAPoner)
      }) 
  }

  method generarEsquinas(){
    tipo.esquinas().forEach({e =>
      tipo.asignarImagenSegunCoordenadas(e)                
      const esquinaAPoner = object {
        const property position = game.at(e.get(0), e.get(1))
        var property image = tipo.image()
      }
      
      game.addVisual(esquinaAPoner)
    
    })
  }
  
}

class PisoInterior inherits Muro {
  
  const alturas = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
  method rellenarInteriorAAltura(altura){
    (1..game.width() - 2).forEach({ x =>
      const muroAPoner = object {
        const property position = game.at(x,altura)
        var property image = "3x-interior-roca.png"
      }
      game.addVisual(muroAPoner)
    }
    ) 
    
  }
  method rellenarInterior(){
    alturas.forEach({h =>
      self.rellenarInteriorAAltura(h)
    })
  }
  
}




object bloqueSur {
  const property coordenadaFija = 0
  var property position = game.at(1,0)
  var property image = "3x-borde-sur-1-roca.png"
  method asignarImagenSegunCoordenadaX(x){
    if (x % 3 == 1){
      image = "3x-borde-sur-1-roca.png"
    }
    else if (x % 3 == 2){
      image = "3x-borde-sur-2-roca.png"
    }
    else{
      image =  "3x-borde-sur-3-roca.png"
    }
  }
  
}

object bloqueNorte{

  // Por qué no funciona game.width() -1  ????
  const property coordenadaFija = 19
  var property position = game.at(1,0)
  var property image = "3x-borde-norte-1-roca.png"
  method asignarImagenSegunCoordenadaX(x){
    if (x % 3 == 1){
      image = "3x-borde-norte-1-roca.png"
    }
    else if (x % 3 == 2){
      image = "3x-borde-norte-2-roca.png"
    }
    else{
      image =  "3x-borde-norte-3-roca.png"
    }
  }
}

object bloqueOeste{
  const property coordenadaFija = 0
  var property position = game.at(1,0)
  var property image = "3x-borde-norte-1-roca.png"
  method asignarImagenSegunCoordenadaY(y){
    if (y % 2 == 1){
      image = "3x-borde-oeste-1-roca.png"
    }    
    else{
      image =  "3x-borde-oeste-2-roca.png"
    }
  }
}

object bloqueEste{
  const property coordenadaFija = 34
  var property position = game.at(34,0)
  var property image = "3x-borde-norte-1-roca.png"
  method asignarImagenSegunCoordenadaY(y){
    if (y % 2 == 1){
      image = "3x-borde-este-1-roca.png"
    }    
    else{
      image =  "3x-borde-este-2-roca.png"
    }
  }
}

object bloqueEsquina{
  var property position = game.at(0,0)
  var property image = "3x-esquina-SO-roca.png"
  // NO pude instanciar un diccionario aqui, Por qué???
  const property esquinas =[[0,0], [34,0], [34, 19], [0, 19]]

  method asignarImagenSegunCoordenadas(coordenada){
    if (coordenada == [0,0]){
    image = "3x-esquina-SO-roca.png"
    }
    else if (coordenada == [34,0]){
      image = "3x-esquina-SE-roca.png"
    }
    else if (coordenada == [34,19]){
      image = "3x-esquina-NE-roca.png"
    }
    else if (coordenada == [0,19]){
      image = "3x-esquina-NO-roca.png"
    }
  }

  

}
/*
object murosInternos {

  // Genera una estructura interna de rocas en posiciones alternadas (como en Bomberman clásico)
  method generar() {
    const ancho = game.width()
    const alto = game.height()
    
    // Recorremos todas las coordenadas del tablero (excepto bordes)
    (1..ancho - 2 ) .forEach { x =>
      (1..alto - 2).forEach { y =>
        // Creamos muro solo en coordenadas donde ambos (x,y) son pares -> patrón bomberman solo indestructibles pero de a cuatro para que cargue menos
        if (x % 4 == 0 and y % 4 == 0 and x < ancho - 3 and y < alto - 3) {
          const muro = object {
            const property position = game.at(x, y)
            var property image = "muro.png"
          }

          game.addVisual(muro)
          coordenadasBloqueadas.agregarCoordenada([x, y])
        }
      }
    }
  }
}*/



