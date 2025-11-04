@transfer
Feature: Transferencia entre cuentas

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Realizar una transferencia entre cuentas válidas
    Given path 'transfer'
    And param fromAccountId = 16896
    And param toAccountId = 18339
    And param amount = 50.00
    When method POST
    Then status 200
    And match response contains 'Transfer Complete'

