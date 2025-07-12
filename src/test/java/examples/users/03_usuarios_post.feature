Feature: Registrar nuevo usuario

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'
    * call read('classpath:examples/users/datos.feature')
    

    
# Escenario 1

  Scenario: Registrar usuario exitosamente
    * def usuario = crearNuevoUsuario()
    * print 'Usuario generado:', usuario
    * def datos_nuevo_usuario =
      """
      {
      "nome": "#(usuario.nome)",
      "email": "#(usuario.email)",
      "password": "#(usuario.password)",
      "administrador": "#(usuario.administrador)"
      }
      """
    Given path '/usuarios'
    And request datos_nuevo_usuario
    When method post
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string'}


# Escenario 2

  Scenario: Registrar usuario con un correo ya existente
    * def usuario = crearNuevoUsuario()
    * print 'Usuario generado:', usuario
    * def datos_nuevo_usuario =
      """
      {
      "nome": "#(usuario.nome)",
      "email": "beltrano@qa.com.br",
      "password": "#(usuario.password)",
      "administrador": "#(usuario.administrador)"
      }
      """
    Given path '/usuarios'
    And request datos_nuevo_usuario
    When method post
    Then status 400
    And match response == { message: 'Este email já está sendo usado'}


# Escenario 3
  Scenario: Registrar usuario con datos vacios
    * def datos_nuevo_usuario =
      """
      {
      "nome": "",
      "email": "",
      "password": "",
      "administrador": ""
      }
      """
    Given path '/usuarios'
    And request datos_nuevo_usuario
    When method post
    Then status 400
    And match response == {nome:"nome não pode ficar em branco", email:"email não pode ficar em branco", password:"password não pode ficar em branco", administrador:"administrador deve ser 'true' ou 'false'"}
    * print 'La respuesta es', response


# Escenario 4

  Scenario: Registrar usuario con un formato incorrecto de correo
    * def usuario = crearNuevoUsuario()
    * print 'Usuario generado:', usuario
    * def datos_nuevo_usuario =
      """
      {
      "nome": "#(usuario.nome)",
      "email": "beltranoasd.com",
      "password": "#(usuario.password)",
      "administrador": "#(usuario.administrador)"
      }
      """
    Given path '/usuarios'
    And request datos_nuevo_usuario
    When method post
    Then status 400
    And match response == { email: 'email deve ser um email válido'}






