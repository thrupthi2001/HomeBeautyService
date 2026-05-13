package in.sp.main.Controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Admin;
import in.sp.main.Entities.Helper;
import in.sp.main.Entities.HelperReport;
import in.sp.main.Entities.HelperWarning;
import in.sp.main.Services.AdminService;
import in.sp.main.Services.FileUploadService;
import in.sp.main.Services.HelperReportService;
import in.sp.main.Services.HelperService;
import in.sp.main.Services.HelperWarningService;
import in.sp.main.Services.ReviewService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final FileUploadService fileUploadService;
    private final ReviewService reviewService;   // ✅ FIX 1
    private final HelperReportService helperReportService;
    private final HelperWarningService helperWarningService;
    private final HelperService helperService;

    

    public AdminController(AdminService adminService,
                           FileUploadService fileUploadService,
                           ReviewService reviewService,
                           HelperReportService helperReportService,
                           HelperWarningService helperWarningService,
                           HelperService helperService) {  // ✅ FIX 1
        this.adminService = adminService;
        this.fileUploadService = fileUploadService;
        this.reviewService = reviewService;
        this.helperReportService = helperReportService;
        this.helperWarningService = helperWarningService;
        this.helperService = helperService; 
    }

    @GetMapping("/register")
    public String registerPage() {
        return "admin/admin-register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Admin admin,
                           @RequestParam("photo") MultipartFile photo)
            throws IOException {

        if (!photo.isEmpty()) {
            admin.setProfilePhoto(
                    fileUploadService.saveFile(photo, "profile")
            );
        }

        adminService.register(admin);
        return "redirect:/admin/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "admin/admin-login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session) {

        Admin admin = adminService.login(email, password);
        if (admin == null) {
            return "redirect:/admin/login?error";
        }

        session.setAttribute("admin", admin);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        if (session.getAttribute("admin") == null) {
            return "redirect:/admin/login";
        }
        return "admin/admin-dashboard";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        model.addAttribute("admin", session.getAttribute("admin"));
        return "admin/admin-profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute Admin admin,
                                @RequestParam("photo") MultipartFile photo,
                                HttpSession session)
            throws IOException {

        if (!photo.isEmpty()) {
            admin.setProfilePhoto(
                    fileUploadService.saveFile(photo, "profile")
            );
        }

        adminService.update(admin);
        session.setAttribute("admin", admin);
        return "redirect:/admin/profile";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    /* ========= ADMIN → VIEW ALL REVIEWS ========= */
    @GetMapping("/reviews")   // ✅ FIX 2
    public String allReviews(Model model) {

        model.addAttribute("reviews", reviewService.findAll());
        return "admin/reviews";
    }
    
    @GetMapping("/helpers/reliability-v2")
    public String helperReliability(Model model) {
        model.addAttribute("helpers", helperService.getAll());
        model.addAttribute("reportService", helperReportService);
        return "admin/helper-reliability-warn";
    }

    
    @GetMapping("/helpers/reports/{id}")
    public String viewReports(@PathVariable Long id, Model model) {

        var reports = helperReportService.getReports(id);

        model.addAttribute("reports", reports);
        model.addAttribute("warningCount",
                helperWarningService.warningCount(id));

        // ✅ VERY IMPORTANT PART
        Map<Long, List<HelperWarning>> reportWarnings = new HashMap<>();

        for (HelperReport r : reports) {
            reportWarnings.put(
                r.getId(),
                helperWarningService.reportWarnings(r.getId())
            );
        }

        model.addAttribute("reportWarnings", reportWarnings);

        return "admin/helper-reports";
    }


    
    @PostMapping("/helpers/warn")
    public String warn(@RequestParam Long helperId,
                       @RequestParam Long reportId,
                       @RequestParam String message) {

        Helper helper = helperService.getById(helperId);
        HelperReport report = helperReportService.getById(reportId);

        helperWarningService.sendWarning(helper, report, message);

        if (helperWarningService.warningCount(helperId) >= 7) {
            System.out.println("⚠️ DELETE HELPER SUGGESTION");
        }

        return "redirect:/admin/helpers/reports/" + helperId;
    }
    
    
    @GetMapping("/helpers/delete/{id}")
    public String deleteHelper(@PathVariable Long id) {

        helperService.deleteById(id);
        return "redirect:/admin/helpers/reliability-v2";
    }



}
