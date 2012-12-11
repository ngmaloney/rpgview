Feature: Generating new Postgresql View

  Scenario: No schema
    When I run rpgview without a schema argument
    Then it displays a schema not specified error message

  Scenario: Basic UI
    When I get help for "rpgview"
    Then the exit status should be 0

  Scenario: Generating a view
    When I run rpgview using the example schema
    Then it should output the correct sql