@transfer
Feature: Transferencia entre cuentas

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def customerId = 14099
    * def fromAccountId = 16896
    * def toAccountId = 18339
    * def transferAmount = 50.00

  Scenario: Realizar una transferencia entre cuentas válidas y verificar actualización de saldos
    # 🔹 Consultar saldos antes de la transferencia
    Given path 'customers', customerId, 'accounts'
    When method GET
    Then status 200
    * def before = response
    * def fromBefore = before.find(x => x.id == fromAccountId).balance
    * def toBefore = before.find(x => x.id == toAccountId).balance

    # 🔹 Ejecutar transferencia
    Given path 'transfer'
    And param fromAccountId = fromAccountId
    And param toAccountId = toAccountId
    And param amount = transferAmount
    When method POST
    Then status 200
    And match response contains 'Successfully transferred'

    # 🔹 Consultar saldos después de la transferencia
    Given path 'customers', customerId, 'accounts'
    When method GET
    Then status 200
    * def after = response
    * def fromAfter = after.find(x => x.id == fromAccountId).balance
    * def toAfter = after.find(x => x.id == toAccountId).balance

    # 🔹 Validar el cambio en los saldos
    And match fromAfter == fromBefore - transferAmount
    And match toAfter == toBefore + transferAmount
