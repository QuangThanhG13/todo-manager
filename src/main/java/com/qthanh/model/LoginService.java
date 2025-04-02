package com.qthanh.model;

import org.springframework.stereotype.Service;

@Service
public class LoginService {

    public boolean validateUser(String user, String password) {
         return user.equalsIgnoreCase("qthanh") && password.equals("06092004");
    }

}
