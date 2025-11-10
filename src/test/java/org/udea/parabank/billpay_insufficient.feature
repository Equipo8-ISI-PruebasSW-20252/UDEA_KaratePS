@billpay_insufficient
Feature: Pago fallido por saldo insuficiente

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Simular pago fallido por saldo insuficiente
    Given path 'billpay'
    And request
    """
    {
      "name": "Electric Company",
      "address": {
        "street": "123 Main St",
        "city": "Springfield",
        "state": "IL",
        "zipCode": "62701"
      },
      "phoneNumber": "5555555555",
      "accountNumber": 16896,
      "amount": 9999999.99,
      "fromAccountId": 21891
    }
    """
    When method POST
    Then status 400
    * if (responseStatus != 400) karate.match(responseStatus, 422)
    * print '💬 Respuesta del servidor:', response
    * match response contains 'Insufficient' || response contains 'insufficient' || response contains 'error'

