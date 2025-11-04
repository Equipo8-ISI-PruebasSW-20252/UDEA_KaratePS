@billpay_insufficient
Feature: Pago fallido por saldo insuficiente

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def customerId = 14099
    * def fromAccountId = 16896
    * def payeeName = 'Servicios Públicos'
    * def accountNumber = '12345678'
    * def amount = 9999999.99  

  Scenario: Simular pago fallido por saldo insuficiente
    # Obtener el saldo actual de la cuenta origen
    Given path 'customers', customerId, 'accounts'
    When method GET
    Then status 200
    * def accountInfo = response.find(x => x.id == fromAccountId)
    * def balance = accountInfo.balance
    * print 'Saldo actual:', balance

    # Verificar que el monto a pagar es mayor que el saldo (precondición)
    * match amount > balance

    # Intentar realizar el pago con saldo insuficiente
    Given path 'billpay'
    And request
      """
      {
        "customerId": #(customerId),
        "fromAccountId": #(fromAccountId),
        "payeeName": #(payeeName),
        "accountNumber": #(accountNumber),
        "amount": #(amount)
      }
      """
    When method POST
    Then status 400 || status 422
    And match response contains any ['insufficient funds', 'saldo insuficiente', 'not enough balance']
