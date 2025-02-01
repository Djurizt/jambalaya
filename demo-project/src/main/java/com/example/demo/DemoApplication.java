package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping("/carles")
    public String carles(@RequestParam(value = "name", defaultValue = "Carles") String name) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<title>Thank you " + name + "</title>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; text-align: center; }" +
                "h1 { color: #4CAF50; }" +
                "p { font-size: 18px; }" +
                ".message { background-color: #e7f3fe; border-left: 6px solid #2196F3; padding: 20px; display: inline-block; margin: 20px auto; }" +
                ".dcp-message { background-color: #ffe0b2; border-left: 6px solid #ff9800; padding: 20px; margin: 20px auto; display: inline-block; }" +
                "button { padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; font-size: 16px; }" +
                "button:hover { background-color: #45a049; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<h1>Thank you, " + name + "!</h1>" +
                "<div class='message'>" +
                "<p>If you see this message, your offer letter is upcoming. Join the DCP (DevOps Career Path) – you're doing great!</p>" +
                "</div>" +
                "<div class='dcp-message'>" +
                "<p><strong>Propose to all students:</strong> If you've deployed this app successfully, you’re ready to make 6figures! We provide comprehensive guidance, one-on-one mentorship, and exclusive resources to help you land your dream job in DevOps. Take the next step in your career with us!</p>" +
                "</div>" +
                "<button onclick='showAlert()'>Click Me for a Surprise</button>" +
                "<script>" +
                "function showAlert() {" +
                "  alert('You are awesome, " + name + "! Keep it up!');" +
                "}" +
                "</script>" +
                "</body>" +
                "</html>";
    }
}
