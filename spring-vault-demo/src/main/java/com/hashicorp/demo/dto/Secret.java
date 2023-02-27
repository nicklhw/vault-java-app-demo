package com.hashicorp.demo.dto;

public class Secret {

    private String key;
    private String value;

    public Secret(String key, String value) {
        this.key = key;
        this.value = value;
    }

    public String getKey() {
        return key;
    }

    public String getValue() {
        return value;
    }
}
