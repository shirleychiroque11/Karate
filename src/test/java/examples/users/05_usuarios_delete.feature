Feature: Eliminar datos de un usuario

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'
    * call read('classpath:examples/helpers/datos.feature')

    Given path '/usuarios'
    When method get
    And match response.usuarios == '#array'
    * def id_primer_usuario = response.usuarios[0]._id
    * print 'id_primer_usuario (Background):', id_primer_usuario
    
    
# Escenario 1

  Scenario: Eliminar usuario exitosamente
    Given path '/usuarios/' + 'tYGWqr80MVlifjNI'
    When method delete
    Then status 200
    And match response == { message: 'Registro excluído com sucesso'}


# Escenario 2

  Scenario: Eliminar usuario mediante un id inexistente
    * def id_aleatorio = generarTextoAleatorio()
    * print 'Id aleatorio:', id_aleatorio

    Given path '/usuarios/' + 'WWWeAuShq3JnhSF5sdsds'
    When method delete
    Then status 200
    And match response == { message: 'Nenhum registro excluído'}
  
# Escenario 3

  Scenario: Eliminar usuario que tenga productos en el carrito
    * def id_aleatorio = generarTextoAleatorio()
    * print 'Id aleatorio:', id_aleatorio

    Given path '/usuarios/' + id_aleatorio
    When method delete
    Then status 400
    And match response == { message: 'Não é permitido excluir usuário com carrinho cadastrado', idCarrinho: "#string"}