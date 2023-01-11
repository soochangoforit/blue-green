package deploy.test;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {


    @GetMapping("/")
    public String index() {
        return "Hello World!";
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
