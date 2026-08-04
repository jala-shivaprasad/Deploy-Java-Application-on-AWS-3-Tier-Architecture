package com.dpt.demo.dao;

import java.util.List;
import java.util.Optional;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.dpt.demo.model.Employee;

/**
 * Data access for the "Employee" table.
 *
 * Replaces the previous raw DriverManager.getConnection(...) + string-concatenated
 * SQL with Spring's JdbcTemplate:
 *  - every statement is a PreparedStatement, so SQL injection via username/
 *    password/email/etc. is no longer possible.
 *  - connections come from the Spring Boot-managed (HikariCP) pool instead of
 *    opening/closing a brand-new physical connection on every request.
 *
 * The table schema itself is untouched.
 */
@Repository
public class EmployeeDao {

    private static final String COLUMNS =
            "id, first_name, last_name, email, username, password, regdate";

    private final JdbcTemplate jdbcTemplate;

    public EmployeeDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private static final RowMapper<Employee> ROW_MAPPER = (rs, rowNum) -> {
        Employee e = new Employee();
        e.setId(rs.getLong("id"));
        e.setFirstName(rs.getString("first_name"));
        e.setLastName(rs.getString("last_name"));
        e.setEmail(rs.getString("email"));
        e.setUsername(rs.getString("username"));
        e.setPassword(rs.getString("password"));
        e.setRegDate(rs.getTimestamp("regdate"));
        return e;
    };

    public Optional<Employee> findByUsername(String username) {
        try {
            Employee e = jdbcTemplate.queryForObject(
                    "SELECT " + COLUMNS + " FROM Employee WHERE username = ?",
                    ROW_MAPPER, username);
            return Optional.ofNullable(e);
        } catch (EmptyResultDataAccessException ex) {
            return Optional.empty();
        }
    }

    public Optional<Employee> findById(Long id) {
        try {
            Employee e = jdbcTemplate.queryForObject(
                    "SELECT " + COLUMNS + " FROM Employee WHERE id = ?",
                    ROW_MAPPER, id);
            return Optional.ofNullable(e);
        } catch (EmptyResultDataAccessException ex) {
            return Optional.empty();
        }
    }

    public boolean existsByUsername(String username) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM Employee WHERE username = ?", Integer.class, username);
        return count != null && count > 0;
    }

    public boolean existsByEmail(String email) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM Employee WHERE email = ?", Integer.class, email);
        return count != null && count > 0;
    }

    /** Inserts a new employee and returns the generated id. */
    public Long insert(Employee employee) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> {
            java.sql.PreparedStatement ps = connection.prepareStatement(
                    "INSERT INTO Employee (first_name, last_name, email, username, password, regdate) " +
                            "VALUES (?, ?, ?, ?, ?, CURDATE())",
                    java.sql.Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, employee.getFirstName());
            ps.setString(2, employee.getLastName());
            ps.setString(3, employee.getEmail());
            ps.setString(4, employee.getUsername());
            ps.setString(5, employee.getPassword());
            return ps;
        }, keyHolder);
        Number key = keyHolder.getKey();
        return key != null ? key.longValue() : null;
    }

    public void updateProfile(Long id, String firstName, String lastName, String email) {
        jdbcTemplate.update(
                "UPDATE Employee SET first_name = ?, last_name = ? , email = ? WHERE id = ?",
                firstName, lastName, email, id);
    }

    public void updatePassword(Long id, String newHashedPassword) {
        jdbcTemplate.update(
                "UPDATE Employee SET password = ? WHERE id = ?",
                newHashedPassword, id);
    }

    public List<Employee> findAll() {
        return jdbcTemplate.query("SELECT " + COLUMNS + " FROM Employee ORDER BY id", ROW_MAPPER);
    }
}
