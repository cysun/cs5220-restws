package restws.web.service;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NumberService {

    @RequestMapping("/service/number")
    public String number()
    {
        return Math.random() + "";
    }

}
