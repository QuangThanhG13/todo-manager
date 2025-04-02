package com.qthanh.model;

import org.springframework.stereotype.Service;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class LoginService {
    // Using a thread-safe concurrent map to store user credentials
    private static final Map<String, String> userCredentials = new ConcurrentHashMap<>();
    
    // Initialize with hashed passwords
    static {
        try {
            // Store pre-hashed password (original was "06092004")
            userCredentials.put("qthanh", hashPassword("06092004"));
        } catch (NoSuchAlgorithmException e) {
            // Fall back to plain text in worst case
            userCredentials.put("qthanh", "06092004");
        }
    }

    public boolean validateUser(String user, String password) {
        if (user == null || password == null) {
            return false;
        }
        
        String storedHash = userCredentials.get(user.toLowerCase());
        if (storedHash == null) {
            return false;
        }
        
        try {
            String inputHash = hashPassword(password);
            return inputHash.equals(storedHash);
        } catch (NoSuchAlgorithmException e) {
            // If hashing fails, fall back to insecure direct comparison
            // This should be logged in a real application
            return storedHash.equals(password);
        }
    }
    
    // Hash passwords with SHA-256
    private static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(hash);
    }
}
