Feature: Modulo de autenticación

  @login
  Scenario: CP01-inicio de sesion exitoso
    * def data = read('classpath:resources/json/auth/data.json')[0]
    Given url urlBase
    And path "api/login"
    And request data
    When method post
    Then status 200
    And match response.access_token != null
    * def token = response.access_token
    * print token



  @login_invalid
  Scenario: CP02-inicio de sesion fallido con email incorrecto
    * def data = read('classpath:resources/json/auth/data.json')[1]
    Given url urlBase
    And path "api/login"
    And request data
    When method post
    Then status 401
    And match response.message == "Datos incorrectos"