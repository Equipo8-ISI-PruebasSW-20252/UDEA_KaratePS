@transfer
Feature: Transferencia entre cuentas

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * def fromAccountId = 16896 
    * def toAccountId = 18339
    * def amount = 50.00

  Scenario: Realizar una transferencia entre cuentas válidas y verificar actualización de saldos
    # Obtener balances antes de la transferencia
    Given path 'customers/14099/accounts'
    When method GET
    Then status 200
    * def before = response
    * def fromBefore = before.find(x => x.id == fromAccountId).balance
    * def toBefore = before.find(x => x.id == toAccountId).balance

    # Ejecutar transferencia
    Given path 'transfer'
    And param fromAccountId = fromAccountId
    And param toAccountId = toAccountId
    And param amount = amount
    When method POST
    Then status 200
    And match response contains 'Successfully transferred'

    # Consultar balances después de la transferencia
    Given path 'customers/14099/accounts'
    When method GET
    Then status 200
    * def after = response

    # Convertir estructura según el tipo de respuesta (JSON o XML)
    * def accounts = after.accounts ? after.accounts.account : after
    * def fromAfter = accounts.find(x => x.id == fromAccountId).balance
    * def toAfter = accounts.find(x => x.id == toAccountId).balance

    # Validar actualización de saldos
    * match fromAfter == fromBefore - amount
    * match toAfter == toBefore + amount
