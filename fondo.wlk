import wollok.game.*


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

object coordenadasBorde{
  const property coordenadas = #{[0,0], [1,0], [2,0], [3,0], [4,0], [5,0], [6,0], [7,0], [8,0], [9,0], [10,0], [11,0], [12,0], [13,0], [14,0], [15,0], [16,0], [17,0], [18,0], [19,0], [20,0], [21,0], [22,0], [23,0], [24,0], [25,0], [26,0], [27,0], [28,0], [29,0], [30,0], [31,0], [32,0], [33,0], [34,0], [34,1], [34,2], [34,3], [34,4], [34,5], [34,6], [34,7], [34,8], [34,9], [34,10], [34,11], [34,12], [34,13], [34,14], [34,15], [34,16], [34,17], [34,18], [34,19], [33,19], [32,19], [31,19], [30,19], [29,19], [28,19], [27,19], [26,19], [25,19], [24,19], [23,19], [22,19], [21,19], [20,19], [19,19], [18,19], [17,19], [16,19], [15,19], [14,19], [13,19], [12,19], [11,19], [10,19], [9,19], [8,19], [7,19], [6,19], [5,19], [4,19], [3,19], [2,19], [1,19], [0,19], [0,18], [0,17], [0,16], [0,15], [0,14], [0,13], [0,12], [0,11], [0,10], [0,9], [0,8], [0,7], [0,6], [0,5], [0,4], [0,3], [0,2], [0,1]}

}




