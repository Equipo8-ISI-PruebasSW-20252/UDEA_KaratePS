@parabank_transfer
Feature: Transferencia entre cuentas

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Realizar una transferencia entre cuentas válidas
    Given path 'transfer'
    And form field fromAccountId = 16896
    And form field toAccountId = 18339
    And form field amount = 50.00
    When method POST
    Then status 200
    And match response contains 'Transfer Complete'
