@parabank_transfer
Feature: Transferencia entre cuentas

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Realizar una transferencia entre cuentas válidas
    Given path 'transfer'
    And request
    """
    {
      "fromAccountId": 16896,
      "toAccountId": 18339,
      "amount": 50.00
    }
    """
    When method POST
    Then status 200
    And match response contains { message: '#string' }
    And match response.message == 'Transfer Complete!'
