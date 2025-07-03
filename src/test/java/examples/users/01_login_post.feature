Feature: Inicio de sesión del Administrador

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'
    * call read('classpath:examples/helpers/datos.feature')
    
  # Escenario 2  
    Scenario: Iniciar sesión con credenciales inválidas
    * def credenciales_login_request =
      """
      {
      "email": "alfredtest@qa.com",
      "password": "alfred#7456"
      }
      """
    Given path '/login'
    And request credenciales_login_request
    When method post 
    Then status 200 
    And match response == {message:'Email e/ou senha inválidos'}    

# Escenario 3  
    Scenario: Iniciar sesión con credenciales vacíos
    * def credenciales_login_request =
      """
      {
      "email": "",
      "password": ""
      }
      """
    Given path '/login'
    And request credenciales_login_request
    When method post
    Then status 400 
    And match response == {email:'email não pode ficar em branco', password: 'password não pode ficar em branco'}    

# Escenario 4  
    Scenario: Iniciar sesión con formato de correo incorrecto
    * def credenciales_login_request =
      """
      {
      "email": "prueba",
      "password": "teste"
      }
      """
    Given path '/login'
    And request credenciales_login_request
    When method post
    Then status 400 
    And match response == {email:'email deve ser um email válido'}
