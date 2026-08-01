Feature: Modulo de autenticación

  @login
  Scenario: CP01-inicio de sesion exitoso
    Given url urlBase
    And path "api/login"
    And request { "email":