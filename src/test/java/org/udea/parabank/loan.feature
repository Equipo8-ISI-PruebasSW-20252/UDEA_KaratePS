@loan
Feature: Simulación de préstamo

  Background:
    * url baseUrl
    * header Accept = 'application/json'

  Scenario: Solicitar préstamo y verificar respuesta
    Given path 'requestLoan'
    And param customerId = 12434
    And param fromAccountId = 18894
    And param amount = 1000
    And param downPayment = 100
    When method POST
    Then status 200
    And match response == { approved: '#boolean', accountId: '#number' }
    * print '💬 Resultado del préstamo:', response
