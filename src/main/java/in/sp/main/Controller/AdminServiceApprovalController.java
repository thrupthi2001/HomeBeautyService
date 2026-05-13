package in.sp.main.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Entities.Service;
import in.sp.main.Services.ServiceService;

@Controller
@RequestMapping("/admin/services")
public class AdminServiceApprovalController {

    private final ServiceService serviceService;

    public AdminServiceApprovalController(ServiceService serviceService) {
        this.serviceService = serviceService;
    }

    @GetMapping("/pending")
    public String pendingServices(Model model) {
        model.addAttribute("services",
                serviceService.getByStatus("PENDING"));
        return "admin/pending-services";
    }

    @GetMapping("/approve/{id}")
    public String approve(@PathVariable Long id) {
        Service service = serviceService.getById(id);
        service.setStatus("APPROVED");
        serviceService.save(service);
        return "redirect:/admin/services/pending";
    }
    
 // SHOW REJECT PAGE
    @GetMapping("/reject/{id}")
    public String rejectPage(@PathVariable Long id, Model model) {
        model.addAttribute("service", serviceService.getById(id));
        return "admin/service-reject";
    }

    // HANDLE REJECT SUBMIT
    @PostMapping("/reject")
    public String rejectService(
            @RequestParam Long id,
            @RequestParam String reason
    ) {
        Service service = serviceService.getById(id);
        service.setStatus("REJECTED");
        service.setRejectReason(reason);
        serviceService.save(service);

        return "redirect:/admin/services/pending";
    }

}
