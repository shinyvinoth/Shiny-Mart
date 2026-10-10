package com.shiny.shinymart.util;

/**
 * Run this locally (it has a main method) to generate a real bcrypt hash for seed.sql.
 * From your IDE: right-click this file → Run 'HashGenerator.main()' with the plain
 * password as the program argument, e.g. "password123".
 */
public class HashGenerator {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: HashGenerator <plainPassword>");
            return;
        }
        System.out.println(PasswordUtil.hash(args[0]));
    }
}
