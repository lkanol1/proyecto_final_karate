package bdd;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    Karate testLogin() {
        return Karate.run("loginAuth").relativeTo(getClass());
    }

    @Karate.Test
    Karate testRegister() {
        return Karate.run("registerAuth").relativeTo(getClass());
    }

    @Karate.Test
    Karate testAddProduct() {
        return Karate.run("product/addProduct").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUpdateProduct() {
        return Karate.run("product/updateProduct").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetProduct() {
        return Karate.run("product/get_by_product").relativeTo(getClass());
    }
}