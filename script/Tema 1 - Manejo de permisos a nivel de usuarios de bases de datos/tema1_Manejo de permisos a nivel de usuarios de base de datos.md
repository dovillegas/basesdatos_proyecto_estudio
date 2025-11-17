# Tema 1: Manejo de permisos a nivel de usuarios de base de datos.
  Los permisos de bases de datos en SQL Server son reglas que determinan qué acciones puede realizar un usuario o rol dentro de una base de datos específica. 
  Los permisos y roles de bases de datos en SQL Server sirven para controlar el acceso y las acciones que cada usuario puede realizar dentro de una base de datos. 
  Son fundamentales para garantizar la seguridad, la integridad de los datos y una administración eficiente.
  - Usuarios de bases de datos: Un usuario de base de datos es una identidad dentro de una base específica que representa a alguien (o algo) que puede acceder y operar sobre los objetos de esa base de datos, que son las tablas, vistas, procedimientos, etc.
  - PERMISOS: Los permisos son derechos que se asignan a un usuario, así se define que puede hacer o no en una base de datos.
     - Se pueden agregar permisos específicos a diferentes usuarios. La mayoría de la asignacion de permiso tienen el siguiente formato:
      `<authorization> <permission> ON <securable>::<name> TO <principal>;`

        Donde:
       
       `<authorization>` debe ser GRANT, REVOKEo DENY.
       
       `<permission>` establece la acción que permite o prohíbe.
       
       `ON <securable>::<name>` es el tipo de elemento protegible (servidor, objeto de servidor, base de datos u objeto de base de datos) y su nombre.<authorization> debe ser GRANT, REVOKEo DENY.
       
       `<permission>` establece la acción que permite o prohíbe.
       
       `ON <securable>::<name>` es el tipo de elemento protegible (servidor, objeto de servidor, base de datos u objeto de base de datos) y su nombre.

       Ejemplos de permisos: <br>
      GRANT SELECT ON dbo.Clientes TO UsuarioVentas; <br>
      DENY DELETE ON dbo.Clientes TO UsuarioVentas; <br>
      REVOKE UPDATE ON dbo.Clientes FROM UsuarioVentas; <br>

      - GRANT: Otorga un permiso.
      - REVOKE: Revoca permiso previamente otorgado o denegado.
      - DENY: Niega permiso explícitamente (tiene prioridad sobre GRANT). 
       
- ROLES: <br>
  Un rol de bases de datos es un conjunto de permisos que pueden ser asignados a uno o varios usuarios, que tentrán permisos comunes.
  - Existen dos tipos de roles en el nivel de base de datos: los roles fijos de base de datos que están predefinidos en la base de datos y los roles de base de datos definidos por el usuario que el usuario puede crear.
  - Los roles fijos de base de datos se definen en el nivel de base de datos y existen en cada una de ellas.
  - Para asignar un rol a un usuario se utiliza la siguiente cláusula: <br>
    En el siguiente ejemplo se agrega el usuario 'Ben' al rol en el nivel de base de datos fijo db_datareader. <br>
    `ALTER ROLE db_datareader ADD MEMBER Ben;` <br>
  Ejemplos de roles fijos de base de datos:
    - db_owner: acceso total a la base.
    - db_datareader: puede hacer SELECT en todas las tablas.
    - db_datawriter: puede INSERT, UPDATE, DELETE en todas las tablas.
    - db_ddladmin: puede crear y modificar objetos.

      

- ROLES A NIVEL DE SERVIDOR: <br> Los permisos a nivel de servidor en un DBMS como SQL Server son privilegios que afectan a toda la instancia del servidor, no solo a una base de datos específica. Se gestionan mediante roles fijos de servidor (como sysadmin, serveradmin, securityadmin) y permiten realizar tareas globales como crear bases de datos, administrar logins, configurar el servidor o detener la instancia del servidor. <br>
- PERMISOS Y ROLES A NIVEL DE BASES DE DATOS: <br> Los permisos a nivel de base de datos son privilegios que se aplican dentro de una base específica, no en todo el servidor.
Controlan qué operaciones puede realizar un usuario sobre los objetos de esa base de datos  por ejemplo, Tablas, Vistas, Procedimientos, Esquemas, etc.


  **CONCLUSIÓN:** El manejo de permisos y roles de bases de datos son muy utiles en terminos de seguridad, porque no permite el acceso no deseado de los datos y tambien proteger la integridad de los datos. <br>
en los sistemas de información es muy importante garantizar la seguridad de los datos para que los usuarios confíen en que sus datos están protegidos. 
tambien ayuda a poder asignar las funciones que pueden ejercer cada usuario del sistema y facilitar la asignación de roles para cada funcionalidad e impedir el acceso a datos que no son acorde a su funcionalidad.

      


