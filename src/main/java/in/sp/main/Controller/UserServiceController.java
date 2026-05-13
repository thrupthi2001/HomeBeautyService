package in.sp.main.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Services.ServiceService;
import in.sp.main.Services.ReviewService;

@Controller
@RequestMapping("/services")
public class UserServiceController {

    private final ServiceService serviceService;
    private final ReviewService reviewService;

    public UserServiceController(ServiceService serviceService,
                                 ReviewService reviewService) {
        this.serviceService = serviceService;
        this.reviewService = reviewService;
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable Long id, Model model) {

        model.addAttribute("service", serviceService.getById(id));
        model.addAttribute("reviews", reviewService.findByService(id));

        return "service/details";
    }
}
