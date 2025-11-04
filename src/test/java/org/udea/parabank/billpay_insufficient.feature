@billpay_insufficient
Feature: Pago fallido por saldo insuficiente

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fromAccountId = 16896
    * def payee = 'Electric Company'
    * def accountId = fromAccountId
    * def amount = 9999999.99
    * def description = 'Pago con saldo insuficiente'

  Scenario: Simular pago fallido por saldo insuficiente
    # Obtener balance actual
    Given path 'customers/14099/accounts'
    When method GET
    Then status 200
    * def before = response
    * def account = before.find(x => x.id == accountId)
    * print 'Saldo disponible:', account.balance

    # Intentar pago con monto mayor al saldo
    Given path 'billpay'
    And param payeeName = payee
    And param accountId = accountId
    And param amount = amount
    And param fromAccountId = fromAccountId
    And param description = description
    When method POST
    Then status 400 || status 422
    And match response contains any ['Insufficient funds', 'insufficient', 'error', 'Invalid amount']
