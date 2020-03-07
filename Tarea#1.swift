import Foundation

func Custom_Array(cadena:String, cantidad:Int) {
    var Custom_Array = [String]()
   
    for Posicion in 0...cantidad-1 {
    Custom_Array.insert(cadena, at: Posicion);
    }
    
    print(Custom_Array)

}

func Numbers_List(cantidad:Int) {
     
    for number in 1...cantidad {
        if number % 2 == 0 {
            print("\(number) es número par")
        } else {
            print("\(number) es número impar")
        }
    
    }   

}

func Longest_String(cadena1:String, cadena2:String) {
        
        if cadena1.count > cadena2.count {
            print("\(cadena1) es la cadena más larga ")
        } else {
            if cadena1.count < cadena2.count { 
                print("\(cadena2) es la cadena más larga ")
            } else {
                print("Cadenas son de igual tamaño")
            }
        }
}

func Fibonacci_Number(numero:Int) {
       
        var primer_numero = 0
        var segundo_numero = 1  
        var suma = primer_numero + segundo_numero           

        while suma != numero && suma < numero {            
            suma = primer_numero
            primer_numero = segundo_numero
            segundo_numero = segundo_numero + suma    
            suma = primer_numero + segundo_numero    
        }        
        if suma == numero || numero == 0 {
                print("\(numero) pertenece a la Serie Fibonacci");
            }
            else {
                print("\(numero) NO pertenece a la Serie Fibonacci");
            }
}

Custom_Array(cadena:"iphone", cantidad: 5);
Numbers_List(cantidad: 7);
Longest_String(cadena1:"Computadora", cadena2:"PC");
Fibonacci_Number(numero: 21);



