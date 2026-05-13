package in.sp.main.Controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.Helper;
import in.sp.main.Services.ReliabilityService;
import in.sp.main.Services.ReviewService;
import in.sp.main.Repositories.HelperRepository;
import in.sp.main.Repositories.BookingRepository;
import in.sp.main.Repositories.ServiceRepository;

@Controller
@RequestMapping("/admin/helpers")
public class AdminHelperController {

    private final HelperRepository helperRepo;
    private final ServiceRepository serviceRepo;
    private final BookingRepository bookingRepo;
    private final ReliabilityService reliabilityService;
    private final ReviewService reviewService;

    

    public AdminHelperController(
            HelperRepository helperRepo,
            ServiceRepository serviceRepo,
            BookingRepository bookingRepo,
            ReliabilityService reliabilityService,
            ReviewService reviewService) {

        this.helperRepo = helperRepo;
        this.serviceRepo = serviceRepo;
        this.bookingRepo = bookingRepo;
        this.reliabilityService = reliabilityService;
        this.reviewService = reviewService;
    }

    // 🔹 LIST ALL HELPERS
    @GetMapping
    public String listHelpers(Model model) {

        List<Helper> helpers = helperRepo.findAll();

        model.addAttribute("helpers", helpers);
        model.addAttribute("serviceRepo", serviceRepo);
        model.addAttribute("bookingRepo", bookingRepo);

        return "admin/helper-list";
    }

    // 🔹 VIEW SERVICES BY HELPER
    @GetMapping("/{id}/services")
    public String viewHelperServices(@PathVariable Long id, Model model) {

        Helper helper = helperRepo.findById(id).orElse(null);

        model.addAttribute("helper", helper);
        model.addAttribute("services",
                serviceRepo.findAll()
                        .stream()
                        .filter(s -> s.getCategory().equals(helper.getCategory()))
                        .toList()
        );

        return "admin/helper-services";
    }

    // 🔹 VIEW COMPLETED JOBS
    @GetMapping("/{id}/completed-jobs")
    public String completedJobs(@PathVariable Long id, Model model) {

        Helper helper = helperRepo.findById(id).orElse(null);

        model.addAttribute("helper", helper);
        model.addAttribute("jobs",
                bookingRepo.findByHelperIdAndStatus(id, "COMPLETED"));

        return "admin/helper-completed-jobs";
    }
    
 // 🛡️ HELPER RELIABILITY PAGE
    @GetMapping("/reliability")
    public String helperReliability(Model model) {

        List<Helper> helpers = helperRepo.findAll();

        model.addAttribute("helpers", helpers);
        model.addAttribute("bookings", bookingRepo.findAll());
        model.addAttribute("reviews", reviewService.findAll());
        model.addAttribute("reliabilityService", reliabilityService);

        return "admin/helper-reliability";
    }
    
 // 🗑️ DELETE HELPER (ONLY IF RISKY & NO ACTIVE JOBS)
    @PostMapping("/{id}/delete")
    public String deleteHelper(@PathVariable Long id,
                               RedirectAttributes redirect) {

        Helper helper = helperRepo.findById(id).orElse(null);

        if (helper == null) {
            redirect.addFlashAttribute("error", "Helper not found");
            return "redirect:/admin/helpers/reliability";
        }

        // ❌ Check active jobs
        boolean hasActiveJobs = bookingRepo.findByHelperIdAndStatusIn(
                id,
                List.of("BOOKED", "ACCEPTED", "ON_THE_WAY", "IN_PROGRESS")
        ).size() > 0;

        if (hasActiveJobs) {
            redirect.addFlashAttribute(
                "error",
                "❌ Helper is currently assigned to a job. Delete after completion."
            );
            return "redirect:/admin/helpers/reliability";
        }

        helperRepo.delete(helper);

        redirect.addFlashAttribute(
            "success",
            "✅ Helper deleted successfully"
        );

        return "redirect:/admin/helpers/reliability";
    }


}
