@parabank_accounts
Feature: Consulta de cuentas del cliente

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Obtener y validar cuentas del usuario
    Given path 'customers', 13211, 'accounts'
    When method GET
    Then status 200
    And match each response == { id: '#number', customerId: '#number', type: '#string', balance: '#number' }


    * def total = response.reduce(function(acc, item){ return acc + item.balance }, 0)
