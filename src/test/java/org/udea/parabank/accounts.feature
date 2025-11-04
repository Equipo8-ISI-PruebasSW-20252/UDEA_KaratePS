@parabank_accounts
Feature: Consulta de cuentas del cliente

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Obtener y validar cuentas del usuario
    Given path 'customers', 14099, 'accounts'
    When method GET
    Then status 200
    And match response ==
    """
    [
      { "id": 16896, "customerId": 14099, "type": "CHECKING", "balance": 95.50 },
      { "id": 18339, "customerId": 14099, "type": "SAVINGS",  "balance": 240.00 },
      { "id": 18561, "customerId": 14099, "type": "CHECKING", "balance": 90.00 },
      { "id": 18672, "customerId": 14099, "type": "CHECKING", "balance": 90.00 }
    ]
    """

    * def total = response.reduce(function(acc, item){ return acc + item.balance }, 0)
    And match total == 515.50
