Feature: Módulo de Actualizar productos

  Background:
    * def apilogin = call read('../auth/loginAuth.feature@login')
    * def token = apilogin.token

    @update_product
    Scenario: CP01-Actualizar producto OK
      Given url urlBase
      And header Authorization = 'Bearer ' + token
      And path "api/v1/producto/1"
      And request
      """
       {
          "codigo": "HPuu03",
          "nombre": "Lapt PHP",
          "medida": "UND ",
          "marca": "Generico",
          "categoria": "Repuestos",
          "precio": "8000.00",
          "stock": "10",
          "estado": "3",
          "descripcion": "Ploma 14 pulgadas"
       }
        """
      When method put
      Then status 200


    @update_product_invalid
    Scenario: CP02-Actualizar producto fallido con ID no existente
      Given url urlBase
      And header Authorization = 'Bearer ' + token
      And path "api/v1/producto/999999"
      And request
      """
      {
        "codigo": "HPuu04",
        "nombre": "Producto No Existe",
        "medida": "UND",
        "marca": "Generico",
        "categoria": "Repuestos",
        "precio": "5000.00",
        "stock": "5",
        "estado": "1",
        "descripcion": "Producto inexistente"
      }
      """
      When method put
      Then status 500
      And match response.error contains "member function"
