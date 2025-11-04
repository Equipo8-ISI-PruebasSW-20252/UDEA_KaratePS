@parabank_accounts
Feature: Consulta de cuentas del cliente

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Obtener y validar cuentas del usuario
    Given path 'services', 'bank', 'customers', 14099, 'accounts'
    When method GET
    Then status 200
    And match response ==
    """
    [
      { "id": 16896, "type": "CHECKING", "balance": 245.50 },
      { "id": 18339, "type": "SAVINGS",  "balance": 90.00 },
      { "id": 18561, "type": "SAVINGS",  "balance": 90.00 },
      { "id": 18672, "type": "SAVINGS",  "balance": 90.00 }
    ]
    """
    * def total = response.reduce(function(acc, item){ return acc + item.balance }, 0)
    And match total == 515.50
