package com.dpt.demo.service;

import java.util.Optional;
import java.util.regex.Pattern;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.dpt.demo.dao.EmployeeDao;
import com.dpt.demo.model.Employee;

/**
 * Business logic for employee registration / authentication / profile management.
 * Keeps the Employee table schema exactly as-is; only how we read/write the
 * "password" column changes (see authenticate()).
 */
@Service
public class EmployeeService {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern USERNAME_PATTERN =
            Pattern.compile("^[a-zA-Z0-9_.]{3,50}$");

    private final EmployeeDao employeeDao;
    private final BCryptPasswordEncoder passwordEncoder;

    public EmployeeService(EmployeeDao employeeDao, BCryptPasswordEncoder passwordEncoder) {
        this.employeeDao = employeeDao;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * Validates and persists a new employee. Password is hashed with BCrypt
     * before it ever reaches the database - the plain value is not stored or logged.
     */
    public Employee register(String firstName, String lastName, String email,
                              String username, String password, String confirmPassword) {

        firstName = trim(firstName);
        lastName = trim(lastName);
        email = trim(email);
        username = trim(username);

        if (isBlank(firstName) || isBlank(lastName) || isBlank(email)
                || isBlank(username) || isBlank(password)) {
            throw new RegistrationException("All fields are required.");
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            throw new RegistrationException("Please enter a valid email address.");
        }
        if (!USERNAME_PATTERN.matcher(username).matches()) {
            throw new RegistrationException(
                    "Username must be 3-50 characters and contain only letters, numbers, '.' or '_'.");
        }
        if (password.length() < 6) {
            throw new RegistrationException("Password must be at least 6 characters long.");
        }
        if (confirmPassword != null && !password.equals(confirmPassword)) {
            throw new RegistrationException("Password and confirm password do not match.");
        }
        if (employeeDao.existsByUsername(username)) {
            throw new RegistrationException("That username is already taken. Please choose another.");
        }
        if (employeeDao.existsByEmail(email)) {
            throw new RegistrationException("An account with that email already exists.");
        }

        Employee employee = new Employee();
        employee.setFirstName(firstName);
        employee.setLastName(lastName);
        employee.setEmail(email);
        employee.setUsername(username);
        employee.setPassword(passwordEncoder.encode(password));

        Long id = employeeDao.insert(employee);
        employee.setId(id);
        return employee.withoutPassword();
    }

    /**
     * Authenticates a username/password pair.
     *
     * The original table may contain passwords stored in plain text from before
     * this change (see README's CREATE TABLE statement - "password varchar(250)",
     * no hashing was ever applied). To upgrade security without locking out
     * existing users or requiring a data migration:
     *   1. If the stored value looks like a BCrypt hash, verify with BCrypt.
     *   2. Otherwise, fall back to a plain-text comparison for backwards
     *      compatibility, and if it matches, transparently re-hash and save
     *      the password so the account is upgraded on next login.
     */
    public Optional<Employee> authenticate(String username, String rawPassword) {
        if (isBlank(username) || isBlank(rawPassword)) {
            return Optional.empty();
        }

        Optional<Employee> found = employeeDao.findByUsername(username.trim());
        if (!found.isPresent()) {
            return Optional.empty();
        }

        Employee employee = found.get();
        String storedPassword = employee.getPassword();
        boolean matches;

        if (isBCryptHash(storedPassword)) {
            matches = passwordEncoder.matches(rawPassword, storedPassword);
        } else {
            matches = storedPassword != null && storedPassword.equals(rawPassword);
            if (matches) {
                // Legacy plaintext record - upgrade it now that we know the password.
                employeeDao.updatePassword(employee.getId(), passwordEncoder.encode(rawPassword));
            }
        }

        return matches ? Optional.of(employee.withoutPassword()) : Optional.empty();
    }

    public Employee updateProfile(Long id, String firstName, String lastName, String email) {
        firstName = trim(firstName);
        lastName = trim(lastName);
        email = trim(email);

        if (isBlank(firstName) || isBlank(lastName) || isBlank(email)) {
            throw new RegistrationException("First name, last name and email are required.");
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            throw new RegistrationException("Please enter a valid email address.");
        }

        Employee existing = employeeDao.findById(id)
                .orElseThrow(() -> new RegistrationException("Employee not found."));

        if (!existing.getEmail().equalsIgnoreCase(email) && employeeDao.existsByEmail(email)) {
            throw new RegistrationException("An account with that email already exists.");
        }

        employeeDao.updateProfile(id, firstName, lastName, email);
        return employeeDao.findById(id).map(Employee::withoutPassword).orElse(null);
    }

    public void changePassword(Long id, String currentPassword, String newPassword, String confirmPassword) {
        if (isBlank(currentPassword) || isBlank(newPassword)) {
            throw new RegistrationException("All password fields are required.");
        }
        if (newPassword.length() < 6) {
            throw new RegistrationException("New password must be at least 6 characters long.");
        }
        if (!newPassword.equals(confirmPassword)) {
            throw new RegistrationException("New password and confirm password do not match.");
        }

        Employee employee = employeeDao.findById(id)
                .orElseThrow(() -> new RegistrationException("Employee not found."));

        String stored = employee.getPassword();
        boolean currentMatches = isBCryptHash(stored)
                ? passwordEncoder.matches(currentPassword, stored)
                : currentPassword.equals(stored);

        if (!currentMatches) {
            throw new InvalidPasswordException("Current password is incorrect.");
        }

        employeeDao.updatePassword(id, passwordEncoder.encode(newPassword));
    }

    public Optional<Employee> findById(Long id) {
        return employeeDao.findById(id).map(Employee::withoutPassword);
    }

    private static boolean isBCryptHash(String value) {
        return value != null && (value.startsWith("$2a$") || value.startsWith("$2b$") || value.startsWith("$2y$"));
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private static String trim(String s) {
        return s == null ? null : s.trim();
    }
}
