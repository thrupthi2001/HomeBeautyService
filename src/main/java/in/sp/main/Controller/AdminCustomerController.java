package in.sp.main.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Repositories.UserRepository;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/customers")
public class AdminCustomerController {

    private final UserRepository userRepository;

    public AdminCustomerController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    // 🔹 LIST ALL CUSTOMERS
    @GetMapping
    public String listCustomers(Model model, HttpSession session) {

        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        model.addAttribute("customers", userRepository.findAll());
        return "admin/customers-list";
    }

    // 🔹 DELETE CUSTOMER
    @PostMapping("/delete/{id}")
    public String deleteCustomer(@PathVariable Long id,
                                 HttpSession session) {

        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }

        userRepository.deleteById(id);
        return "redirect:/admin/customers";
    }
}
