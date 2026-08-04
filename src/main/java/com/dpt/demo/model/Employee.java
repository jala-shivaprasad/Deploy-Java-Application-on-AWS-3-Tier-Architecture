package com.dpt.demo.model;

import java.sql.Timestamp;

/**
 * Domain model mapped to the existing "Employee" table.
 * Schema is unchanged (id, first_name, last_name, email, username, password, regdate)
 * so this class intentionally mirrors it 1:1 - no DB migration required.
 */
public class Employee {

    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private String username;

    // Holds the (hashed) password only while moving data between the DAO and
    // the service layer. Never put this on a ModelAndView / JSP.
    private String password;

    private Timestamp regDate;

    public Employee() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }

    public String getFullName() {
        StringBuilder sb = new StringBuilder();
        if (firstName != null) sb.append(firstName);
        if (lastName != null) {
            if (sb.length() > 0) sb.append(' ');
            sb.append(lastName);
        }
        return sb.length() > 0 ? sb.toString() : username;
    }

    /**
     * Returns a copy with the password removed, safe to put on a ModelAndView
     * or store in the HttpSession without risking it leaking to a JSP/log.
     */
    public Employee withoutPassword() {
        Employee safe = new Employee();
        safe.id = this.id;
        safe.firstName = this.firstName;
        safe.lastName = this.lastName;
        safe.email = this.email;
        safe.username = this.username;
        safe.regDate = this.regDate;
        safe.password = null;
        return safe;
    }
}
