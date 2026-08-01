Feature: Módulo de Agregar productos

  Background:
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token

  @register_product
  Scenario: CP01-Agregar producto OK
    * def randomNum = Math.floor(Math.random() * 999999)
    * def uniqueCodigo = String(randomNum).padStart(6, '0')
    * def uniqueNombre = 'Producto ' + randomNum
    Given url urlBase
    And header Authorization = 'Bearer ' + token
    And path "api/v1/producto"
    And request
    """
    {
      "codigo": "#(uniqueCodigo)",
      "nombre": "#(uniqueNombre)",
      "medida": "UND",
      "marca": "Generico",
      "categoria": "Repuestos",
      "precio": "100.00",
      "stock": "10",
      "estado": "1",
      "descripcion": "Descripción del producto"
    }
    """
    When method post
    Then status 200
    And match response.id != null

  @register_product_StockHigh
  Scenario: CP02-Agregar producto OK con stock alto
    * def randomNum = Math.floor(Math.random() * 999999)
    * def uniqueCodigo = String(randomNum).padStart(6, '0')
    * def uniqueNombre = 'Producto Generico ' + randomNum
    Given url urlBase
    And header Authorization = 'Bearer ' + token
    And path "api/v1/producto"
    And request
    """
    {
      "codigo": "#(uniqueCodigo)",
      "nombre": "#(uniqueNombre)",
      "medida": "UND",
      "marca": "Generico",
      "categoria": "Repuestos",
      "precio": "500.00",
      "stock": "100",
      "estado": "1",
      "descripcion": "Producto Generico con alto stock"
    }
    """
    When method post
    Then status 200
    And match response.stock == "100"

  @register_product_invalid
  Scenario: CP03-Agregar producto fallido con token inválido
    * def randomNum = Math.floor(Math.random() * 999999)
    * def uniqueCodigo = String(randomNum).padStart(6, '0')
    Given url urlBase
    And header Authorization = 'Bearer invalid_token_12345'
    And path "api/v1/producto"
    And request
  """
  {
    "codigo": "#(uniqueCodigo)",
    "nombre": "Producto sin token válido",
    "medida": "UND",
    "marca": "Generico",
    "categoria": "Repuestos",
    "precio": "100.00",
    "stock": "10",
    "estado": "1",
    "descripcion": "Descripción"
  }
  """
    When method post
    Then status 500


  @register_product_duplicate
  Scenario: CP04-Agregar producto fallido con código duplicado
    Given url urlBase
    And header Authorization = 'Bearer ' + token
    And path "api/v1/producto"
    And request
    """
       {
      "codigo": "CP0001",
      "nombre": "Laptop HP",
      "medida": "UND ",
      "marca": "Generico",
      "categoria": "Repuestos",
      "precio": "3500.00",
      "stock": "48",
      "estado": "3",
      "descripcion": "Ploma 14 pulgadas"
       }
      """
    When method post
    Then status 500
    And match response.error != null




