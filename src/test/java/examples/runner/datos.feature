@ignore
Feature: Funciones utilitarias

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

  @ignore
  Scenario: funciones
    * def generarTextoAleatorio =
      """
      function() {
        var result = ''
        var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        for (var i = 0; i < 16; i++) {
          result += characters.charAt(Math.floor(Math.random() * characters.length))
        }
        return result
      }
      """
    * def crearNuevoUsuario =
      """
      function() {
        var timestamp = new Date().getTime()
        return {
          nome: 'Alfred' + timestamp,
          email: 'alfred_' + timestamp + '@gmail.com',
          password: '123456',
          administrador: 'false'
        }
      }
      """
    
    * def credencialCorrecto =
      """
      function() {
        return {
          email: 'cr@gmail.com',
          password: '123456'
        }
      }
      """