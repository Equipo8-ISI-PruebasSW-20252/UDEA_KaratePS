@billpay_insufficient
Feature: Pago fallido por saldo insuficiente

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/x-www-form-urlencoded'

  Scenario: Simular pago fallido por saldo insuficiente
    Given path 'billpay'
    And request { 
      payeeName: 'Electric Company', 
      accountId: 16896, 
      amount: 9999999.99, 
      fromAccountId: 16896, 
      description: 'Pago con saldo insuficiente' 
    }
    When method POST
    Then status 400 || status 422
    And print '💬 Respuesta del servidor:', response
