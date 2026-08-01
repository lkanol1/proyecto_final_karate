Feature: Registrar usuario en el sistema

  Background:
    * def data_users = read('classpath:resources/json/auth/users_add.json')



  @register
  Scenario: CP01-Registrar usuario exitosamente
    * def uniqueEmail = 'user' + java.lang.System.currentTimeMillis() + '@gmail.com'
    * set data_users.email = uniqueEmail
    Given url urlBase
    And path "api/register"
    And request data_users
    When method post
    Then status 200
    And match response.data.id != null
    And match response.access_token != null




  @register_invalid
  Scenario: CP02-Registrar usuario fallido con email duplicado
    * set data_users.email = 'carlosqateam@gmail.com'
    Given url urlBase
    And path "api/register"
    And request data_users
    When method post
    Then status 500
    And match response.email[0] == "The email has already been taken."
