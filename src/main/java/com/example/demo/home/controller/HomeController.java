package com.example.demo.home.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {
    @GetMapping({"/", "home"})
    public String home() {
        return "Hello World!";
    }
    @GetMapping("about")
    public String about() { return "한구루"; }
}
