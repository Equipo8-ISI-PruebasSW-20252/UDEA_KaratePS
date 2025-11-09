@parabank_login
Feature: Login to Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Customer Login
    Given path 'login'
    And path 'Equipo_8' //userName
    And path '123' //password
    When method GET
    Then status 200
    And match response ==
    """
    {
        "id": 12434,
        "firstName": "Equipo_8",
        "lastName": "P_SW",
        "address": {
            "street": "calle 4 # 3 - 2",
            "city": "medellin",
            "state": "antioquia",
            "zipCode": "34567890987654"
        },
        "phoneNumber": "852653",
        "ssn": "4525"
    }
    """
