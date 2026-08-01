Feature: Obtener producto por ID

  Background:
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token
    * def id = Math.floor(Math.random() * 10) + 1

  @get_product
  Scenario: CP01-Obtener producto por ID
    Given url urlBase
    And header Authorization = 'Bearer ' + token
    And path "api/v1/producto/" + id
    When method get
    Then status 200
    * print response
    And match response.id == id

  @get_product_invalid
  Scenario: CP02-Obtener producto fallido con ID inexistente
    Given url urlBase
    And header Authorization = 'Bearer ' + token
    And path "api/v1/producto/999999"
    When method get
    Then status 404
    And match response.error != null