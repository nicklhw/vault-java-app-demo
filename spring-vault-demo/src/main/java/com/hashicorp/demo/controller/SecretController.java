package com.hashicorp.demo.controller;

import com.hashicorp.demo.dto.Secret;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RefreshScope
@RestController
public class SecretController {

    @Value("${secret:n/a}")
    String secret;

//    @Value("${spring.datasource.username:n/a}")
//    String dbusername;
//
//    @Value("${spring.datasource.password:n/a}")
//    String dbpassword;

    @RequestMapping("/api/secret")
    public Secret secret() {
        return new Secret("secret", secret);
    }

//    @RequestMapping("/api/dbcreds")
//    public Secret dbcreds() {
//        return new Secret("dbcreds", String.format("%s : %s", dbusername, dbpassword));
//    }
}