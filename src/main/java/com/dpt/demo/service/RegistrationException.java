package com.dpt.demo.service;

/** Thrown when a registration request fails validation or a uniqueness check. */
public class RegistrationException extends RuntimeException {

    public RegistrationException(String message) {
        super(message);
    }
}
