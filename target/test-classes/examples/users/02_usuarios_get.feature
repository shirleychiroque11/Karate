Feature: Listar todos los usuarios o usuario en especifico que estén registrados en la BD
  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

    Given path '/usuarios'
    When method get
    And match response.usuarios == '#array'
    * def id_primer_usuario = response.usuarios[0]._id
    * print 'id_primer_usuario (Background):', id_primer_usuario

# Escenario 1
  Scenario: Listar usuarios exitosamente
    Given path '/usuarios'
    When method get
    Then status 200 
    And match response.quantidade == response.usuarios.length
    And match each response.usuarios ==
      """
      {
        "nome": "#string",
        "email": "#string",
        "password": "#string",
        "administrador": "#string",
        "_id": "#string"
      }
      """
      * print 'Lista_usuarios:', response.usuarios

# Escenario 2
Scenario: Listar usuarios que no tengan rol administrador
    Given path '/usuarios'
    And param administrador = 'false'
    When method get
    Then status 200 
    And match each response.usuarios ==
      """
      {
        "nome": "#string",
        "email": "#string",
        "password": "#string",
        "administrador": "false",
        "_id": "#string"
      }
      """
    * print 'Usuarios no son administrador:', response.usuarios 

# Escenario 3
  Scenario: Buscar usuario existente por su ID
    Given path '/usuarios/' + id_primer_usuario
    When method get
    Then status 200 
    And match response ==
      """
      {
        "nome": "#string",
        "email": "#string",
        "password": "#string",
        "administrador": "#string",
        "_id": "#string"
      }
      """
     And match response._id == id_primer_usuario 

     * print 'Usuario: ', response

 # Escenario 4
  Scenario: Buscar usuario con ID inexistente
    Given path '/usuarios/' + '0uxuPY0cbmAhpEz1'
    When method get
    Then status 400 
    And match response == {message: 'Usuário não encontrado'} 

 # Escenario 5
  Scenario: Buscar usuario por un ID que supere los 16 caracteres
    Given path '/usuarios/' + 'AABAAuP48cbmAhpEz1'
    When method get
    Then status 400 
    And match response == {id: 'id deve ter exatamente 16 caracteres alfanuméricos'} 