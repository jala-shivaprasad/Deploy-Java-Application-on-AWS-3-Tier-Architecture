package com.dpt.demo.service;

/** Thrown when the current password supplied for a change-password request is wrong. */
public class InvalidPasswordException extends RuntimeException {

    public InvalidPasswordException(String message) {
        super(message);
    }
}
