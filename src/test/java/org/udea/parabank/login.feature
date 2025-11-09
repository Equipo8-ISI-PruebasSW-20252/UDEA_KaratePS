@parabank_login
Feature: Login de Parabank

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Customer Login
    Given path 'login', 'Equipo_8', '123'
    When method GET
    Then status 200
    And match response ==
    """
    {
      id: '#number',
      firstName: '#string',
      lastName: '#string',
      address: '#object',
      phoneNumber: '#string',
      ssn: '#string'
    }
    """
    * print '💬 Login exitoso, ID de cliente:', response.id
