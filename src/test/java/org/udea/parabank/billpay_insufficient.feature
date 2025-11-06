@billpay_insufficient
Feature: Pago fallido por saldo insuficiente

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/x-www-form-urlencoded'

  Scenario: Simular pago fallido por saldo insuficiente
    Given path 'billpay'
    And form field payeeName = 'Electric Company'
    And form field accountId = 16896
    And form field amount = 9999999.99
    And form field fromAccountId = 16896
    And form field description = 'Pago con saldo insuficiente'
    When method POST
    Then status 400
    * if (responseStatus != 400) karate.match(responseStatus, 422)


    * if (typeof response == 'string') print '💬 Respuesta (texto):', response
    * if (typeof response == 'object') print '💬 Respuesta (objeto):', response
    * match response contains 'Insufficient funds' || response contains 'error' || response contains 'insufficient'
