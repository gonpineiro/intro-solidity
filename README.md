### Mapas
Los mapas son estructuras de datos de tipo llave-valor, que permiten apuntar un tipo de dato a otro en forma de diccionario.

El tipo de la llave puede ser cualquier tipo de dato elemental, (por ejemplo, uint), y el tipo de dato del valor puede ser cualquier dato elemental o complejo, (se pueden inclusive hacer estructuras multidimensionales)

```js
mapping(<key type> => <value type>) <visibility> <name>;
```

### Enum
Representa una lista de valores posibles creados por el usuario, una variable del tipo de enum declarado sólo puede tomar los valores enumerados.

```js
enum { <value1>, ..., <valueN> }
```

### Funciones

```js
function <name>(<type> <parameter>..., [..., ]>) 
    <access modifiers>      // public|private|internal|external
    <mutability modifiers>  // view|pure
    <user defined modifiers> 
    <returns>(<type>) {
        <content>
    }
```
    ● public: son accesibles desde todo ámbito posible.
    ● private: solo son accesibles desde el mismo contrato.
    ● internal: solo son accesibles desde el mismo contrato y sus contratos derivados.
    ● external: solo accesibles desde fuera del contrato.

    ● view: indica que la función es de sólo lectura y no modifica el estado del contrato.
    ● pure: indica que no se accede a ningún valor del estado del contrato (o sea sus variables).

### Modificadores
Los modificadores son funciones especiales por el usuario y que se añaden a otra función para envolver su funcionamiento

```js
modifier <name>(<type> <parameter>..., [,...]) {
  <content>
}
```
### El guión bajo
El guión bajo (también conocido como placeholder), es una instrucción especial del modificador que indica dónde se va a ejecutar el código de la función inicial que envuelve al modifier.

##### Primero valida y luego ejecuta

```js
modifier isOwner() {
  if(<condicion>) revert()
  _;
}
```

##### Primero ejecuta y luego valida

```js
modifier isOwner() {
   _;
  if(<condicion>) revert()
}
```

##### Ejecuta, valida y vuelve a ejecutar

```js
modifier isOwner() {
   _;
  if(<condicion>) revert()
   _;
}
```

### Manejo de errores
* assert: Se utiliza para pruebas, compara dos valores
* revert: Es un error que regresa todas las modificaciones de estado realizadas durante la ejecución de la función. Recibe por parámetro un mensaje de error
* require: Es una variación del revert que recibe por parámetro una expresión booleana y revierte si esta expresión es falsa.
Cabe destacar que cualquier consumo de gas ejecutado hasta el momento de un revert se debe pagar, porque el cómputo fué utilizado

### Tipos de almacenamiento
* Storage: Memoria persistente. Es el más costoso. Similar a la memoria ROM
* Memory: Variables temporales durante ejecución. Se asimila a la RAM
* Calldata: Son constantes definidas en el entorno de ejecución de una variable. No son modificables.

### Memoria dinámica
La razón por la que un string necesita un sufijo que indique el uso de memoria, es debido a que es memoria dinámica, por lo que calldata no puede alocar una cantidad definida de memoria, por lo que tenemos que indicarle que esa variable la pase por la memoria volátil (RAM/memory), para que la función la pueda manejar correctamente.

Este efecto ocurre con cualquier cosa que sea de tamaño no definido, por ejemplo: Un arreglo, Un string


### Gas y comisiones
El gas es una unidad de medida para el procesamiento de la EVM. Se mide en unidades de gas, y es constante para las mismas operaciones.

* gasPrice: Es la cantidad de ETH que pagamos por unidad de gas. Es decir, aunque el gas sea constante, la demanda por ese gas puede subir el precio.
* gasCost: Es la cantidad de unidades de gas que generó la ejecución
* gasFee: Gas cost * Gas Price

### Priority fee
A partir del EIP1559 , se realizaron cambios importantes al mercado de gas, y se contempla el priority fee, que es el extra que menciona Sebastián, y es una propina para el minero con la cuál se obtiene prioridad en la ejecución

### Transferencia de ether desde un contrato
* send: Envía un monto a una dirección y retorna false si la transferencia no se realiza
* transfer: Envía un monto y revierte si no se puede realizar
* call: Esta es más complicada, pero básicamente realiza una llamada hacia una dirección. Incluso se pueden llamar funciones de otro contrato si se le pasa un address válido y la llamada dentro del parámetro data. No obstante, al ser un mensaje, puede llevar ether, y por eso se usa para envíos. Retorna el resultado de la función llamada (si es que fué el caso)

1 ETH == 10^18 WEI == 1,000,000,000,000,000,000 WEI

### FORMAS DE RECIBIR ETHER

* receive: función opcional que se ejecuta cuando se recibe una transferencia de Ether sin parámetros.
* Fallback: función opcional que se ejecuta cuando se recibe una transferencia de Ether con parámetros.
* Función payable: se puede recibir Ether en una función si se le especifica el tipo payable.

Cuando se envía una transferencia lo primero que se intenta es verificar si existe una función con la firma especificada.
Si no se encuentra, se buscará una función fallback que reciba parámetros.
Si no tiene parámetros, se buscará una función de receive y en caso de no existir se buscará una función fallback sin parámetros.

### Herencia
"No hay que reinvetar la rueda"

Utilizamos la Herencia para reutilizar codigo en nuevos contratos. Solidity no es POO, pero se comporta similar. Solidity es orientado a contratos. Identificaremos con la sentencia is. Si un contrato tiene un constructor con parametros, debemos indicar que valores debe tomar ese constructor para poder derivarse.

Entonces, se busca generar una relacion entre contratos para reutilizar el codigo mediante la Herencia. Por lo que la capacidad de agregar/modificar una funcion ya escrita en el contrato anterior nos sera de mucha utilidad.

Las funciones `virtuales` son funciones definidas para que se puedan reescrbir por las funciones override. Para esto debemos establecer una relacion de Herencia. Si una funcion virtual no define implementacion, el contrato se convierte en un contrato abstracto. Tambien hay contratos abstractos que usamos como moldes vacios para usar en futuros contratos.

Las `interfaces` no van a tener codigo. su funcion es indicarnos un comportamiento que queremos que tenga un contrato. Solo tiene declaraciones (definiciones de funciones) sin codigo.

* super (sentencia) nos sirve para hacer referencia a una funcion de clase superior.
Ejemplo practico: Buscamos 2 funciones virtuales en Modificadores📗 e Interface📘 para colocar en nuestro archivo/contrato de Herencia 📕📘📗.

Vamos a tener que importar el directorio de los demas contratos, en este caso se encuentran en la misma carpeta los contratos. Coloco los emojis de libros para hacer referencia a un contrato, si hay varios libros es porque es una Herencia que contiene otros contratos.

### Qué es un token
‍Un token es un objeto físico o digital que tiene valor en cierto contexto o para determinada comunidad, aunque su propia materialidad no contenga ese valor en sí.

Las fichas de casino, por ejemplo, son solo pedazos de plástico de distintos colores, pero representan cantidades de dinero. Algunas, hasta millones de dólares, aunque fabricar una de ellas cueste apenas centavos.

Eso hacen los tokens: representan otra cosa, están en su lugar. ¿Por qué? Hay muchos motivos: la comodidad, la seguridad, la facilidad de transportarlos o transferirlos.

En el mundo cripto, los tokens se generan a partir de piezas de código de programación, en formato de contratos inteligentes que corren sobre la blockchain. El smart contract describe cómo funciona cada token. La base de datos lleva el registro de cuántos tiene cada quien. Y los usuarios pueden enviárselos entre sí como forma de transferirse valor.
