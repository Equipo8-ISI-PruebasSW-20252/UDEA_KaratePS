@loan
Feature: Simulación de préstamo

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/x-www-form-urlencoded'

  Scenario: Solicitud de préstamo válida
    Given path 'requestloan'
    And form field amount = 1000
    And form field downPayment = 100
    And form field fromAccountId = 16896
    When method POST
    Then status 200
    And match response contains 'Loan Request Processed' || response contains 'approved' || response contains 'loan'

    * print '💬 Resultado del préstamo:', response
