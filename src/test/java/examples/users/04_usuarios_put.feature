Feature: Editar datos de un usuario

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'
    * call read('classpath:examples/users/datos.feature')

    Given path '/usuarios'
    When method get
    And match response.usuarios == '#array'
    * def id_primer_usuario = response.usuarios[0]._id
    * print 'id_primer_usuario (Background):', id_primer_usuario
    
    
# Escenario 1

  Scenario: Editar usuario exitosamente
    * def usuario = crearNuevoUsuario()
    * print 'Datos de usuario:', usuario
    * def datos_nuevo_usuario =
      """
      {
      "nome": "#(usuario.nome)",
      "email": "#(usuario.email)",
      "password": "#(usuario.password)",
      "administrador": "#(usuario.administrador)"
      }
      """
    Given path '/usuarios/' + id_primer_usuario
    And request datos_nuevo_usuario
    When method put
    Then status 200
    And match response == { message: 'Registro alterado com sucesso'}


# Escenario 2

  Scenario: Editar usuario mediante un id inexistente
    * def usuario = crearNuevoUsuario()
    * print 'Datos de usuario:', usuario
    * def id_aleatorio = generarTextoAleatorio()
    * print 'id aleatorio:', id_aleatorio
    * def datos_nuevo_usuario =
      """
      {
      "nome": "#(usuario.nome)",
      "email": "#(usuario.email)",
      "password": "#(usuario.password)",
      "administrador": "#(usuario.administrador)"
      }
      """
    Given path '/usuarios/' + id_aleatorio
    And request datos_nuevo_usuario
    When method put
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string'}


# Escenario 3
  Scenario: Editar usuario con un correo ya existente
    * def usuario = crearNuevoUsuario()
    * def datos_nuevo_usuario =
      """
      {
      "nome": "#(usuario.nome)",
      "email": "beltrano@qa.com.br",
      "password": "#(usuario.password)",
      "administrador": "#(usuario.administrador)"
      }
      """
    Given path '/usuarios/' + id_primer_usuario
    And request datos_nuevo_usuario 
    When method put
    Then status 400
    And match response == {message:"Este email já está sendo usado"}

