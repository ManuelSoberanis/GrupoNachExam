# GrupoNachExam
Examen para GrupoNoch

//MARK: - Preguntas

6.- Explique el ciclo de vida de un viewcontroller.
El ViewController tiene ciertos periodos en los funcionan diferentes acciones. Un ViewController posee los siguientes estados:

  -La view no ha sido cargada
  -La view está apareciendo
  -La view apareció
  -La view está desapareciendo
  -La view desapareció
  
  -ViewDidLoad() es la primera en cargar, toda la data inicial puede ser cargada en esta.
  -ViewWillAppear() es llamado justo despues del ViewDidLoad(), en este se pueden realizar llamadas al servidor, refrescar o actualizar vistas.
  -ViewDidAppear() es llamado justo despues de que la vista aparece.
  -ViewWillDesappear() esta función es llamada justo antes de que la vista desaparezca.
  -ViewDidDesappear() esta asegura que la vista ya no esta en pantalla.

7.- Explique el ciclo de vida de una aplicación.
El ciclo de vida de una aplicación de iOS son los eventos de ocurren durante el lanzamiento y finalización de la applicación.
Una aplicacion se puede encontrar en los siguientes estados:

  -Not running, la app no ha sido iniciada o fue cerrada por el sistema
  -Inactive state, la app está en el primer plano pero no esta recibiendo eventos
  -Active state, la app esta en primer plano y esta procesando eventos
  -Background state, en este estado la app se encuentra en segundo plano pero puede recibir eventos y ejecutar códico.
  -Suspended state, la app se encuentra en segundo plano pero no esta ejecutando codigo y si el sistema ya no posee sufiente memoria este 
   cerrara la aplicación.

8.- En que caso se usa un weak, un strong y un unowned?
  -Strong es el tipo de referencia por default. Se usa Strong cuando queremos garantizar que siempre podremos acceder a la variable declarada.
   
  -Weak lo podemos utilizar cuando queremos prevenir que el objeto al que hace referencia llegue vacio, ya que para utilizar variables weak hay que hacer un "unwrap".
  
  -Unowned Se usa cuando podemos garantizar que el objeto al que hace referencia no se desasignara. 
  

9.- Que es ARC?
Swift utiliza Automatic Reference Counting (ARC) para rastrear y administrar el uso de memoria de la aplicación. ARC libera automáticamente
la memoria usada por las instancias de las clases cuando estas ya no son necesarias. 


10.-Analiza las siguientes capturas de pantalla y justifica tu respuesta.
Al momento de presentarse el ViewController la vista tendra el color amarilla, ViewDidLoad() se ejecuta primero porque es cuando carga la memoria RAM.
