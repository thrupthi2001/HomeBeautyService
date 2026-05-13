package in.sp.main.Controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.Helper;
import in.sp.main.Entities.HelperWarning;
import in.sp.main.Entities.Review;
import in.sp.main.Services.BookingService;
import in.sp.main.Services.FileUploadService;
import in.sp.main.Services.HelperService;
import in.sp.main.Services.HelperWarningService;
import in.sp.main.Services.ReviewService;
import in.sp.main.Services.ServiceCategoryService;
import in.sp.main.Services.ServiceStreakService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/helper")
public class HelperController {

    private final HelperService helperService;
    private final BookingService bookingService;
    private final FileUploadService fileUploadService;
    private final ReviewService reviewService;
    private final ServiceCategoryService categoryService;
    private final ServiceStreakService serviceStreakService;
    private final HelperWarningService helperWarningService;

    public HelperController(HelperService helperService,
                            BookingService bookingService,
                            FileUploadService fileUploadService,
                            ReviewService reviewService,
                            ServiceCategoryService categoryService,
                            ServiceStreakService serviceStreakService,
                            HelperWarningService helperWarningService) {
        this.helperService = helperService;
        this.bookingService = bookingService;
        this.fileUploadService = fileUploadService;
        this.reviewService = reviewService;
        this.categoryService = categoryService;
        this.serviceStreakService = serviceStreakService;
        this.helperWarningService = helperWarningService;
    }

    /* ================== REGISTER ================== */

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "helper/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Helper helper,
                           @RequestParam("photo") MultipartFile photo)
            throws IOException {

        if (!photo.isEmpty()) {
            helper.setProfilePhoto(
                fileUploadService.saveFile(photo, "profile")
            );
        }

        helperService.register(helper);
        return "redirect:/helper/login";
    }

    /* ================== LOGIN ================== */

    @GetMapping("/login")
    public String loginPage() {
        return "helper/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String phone,
                        @RequestParam String password,
                        HttpSession session) {

        Helper helper = helperService.login(phone, password);
        if (helper == null) {
            return "redirect:/helper/login";
        }

        session.setAttribute("helper", helper);
        return "redirect:/helper/dashboard";
    }
    
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }
        return "helper/dashboard";
    }


    /* ==================  (AVAILABLE JOBS) ================== */

    @GetMapping("/jobs/available")
    public String availableJobs(Model model, HttpSession session) {

        Helper sessionHelper = (Helper) session.getAttribute("helper");
        if (sessionHelper == null) {
            return "redirect:/helper/login";
        }

        // 🔄 ALWAYS REFRESH FROM DB
        Helper helper = helperService.getById(sessionHelper.getId());

        // 🔴 OFFLINE
        if (!helper.isAvailable()) {
            model.addAttribute("offline", true);
            model.addAttribute("bookings", List.of());
            return "helper/available-jobs";
        }

        // 🟢 ONLINE
        model.addAttribute("offline", false);
        model.addAttribute(
            "bookings",
            bookingService.availableBookingsForHelper(helper)
        );

        // 🔄 UPDATE SESSION WITH LATEST HELPER
        session.setAttribute("helper", helper);

        return "helper/available-jobs";
    }



    /* ================== JOB DETAILS ================== */

    @GetMapping("/job/{id}")
    public String jobDetails(@PathVariable Long id,
                             HttpSession session,
                             Model model) {

        if (session.getAttribute("helper") == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute("booking", bookingService.getById(id));
        return "helper/job-details";
    }

    /* ================== ACCEPT JOB ================== */

    @PostMapping("/accept/{id}")
    public String acceptJob(@PathVariable Long id,
                            HttpSession session) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        bookingService.acceptBooking(id, helper);
        return "redirect:/helper/dashboard";
    }

    /* ================== DECLINE JOB ================== */

    @PostMapping("/decline/{id}")
    public String declineJob(@PathVariable Long id,
                             HttpSession session) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        bookingService.declineBooking(id, helper);
        return "redirect:/helper/dashboard";
    }

    /* ================== MY BOOKINGS ================== */

    @GetMapping("/my-bookings")
    public String myBookings(HttpSession session, Model model) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute(
            "bookings",
            bookingService.helperBookings(helper.getId())
        );

        return "helper/my-bookings";
    }

    /* ================== UPDATE JOB STATUS ================== */

    @PostMapping("/status")
    public String updateStatus(@RequestParam Long bookingId,
                               @RequestParam String status) {

        bookingService.updateStatus(bookingId, status);
        return "redirect:/helper/my-bookings";
    }

    /* ================== COMPLETE JOB ================== */

    @PostMapping("/complete")
    public String completeJob(@RequestParam Long bookingId,
                              @RequestParam("proof") MultipartFile proof)
            throws IOException {

        Booking booking = bookingService.getById(bookingId);
        if (booking == null) {
            return "redirect:/helper/my-bookings";
        }

        if (!proof.isEmpty()) {
            booking.setCompletionPhoto(
                fileUploadService.saveFile(proof, "job_proof")
            );
        }

        bookingService.updateStatus(bookingId, "COMPLETED");

        return "redirect:/helper/my-bookings";
    }


    
    /* ================== MY ACTIVE JOBS ================== */
    @GetMapping("/my-jobs")
    public String myJobs(HttpSession session, Model model) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute(
            "jobs",
            bookingService.helperActiveJobs(helper.getId())
        );

        return "helper/my-bookings";   // ACTIVE jobs page
    }

    /* ================== COMPLETED JOBS ================== */
    @GetMapping("/completed-jobs")
    public String completedJobs(HttpSession session, Model model) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute(
            "jobs",
            bookingService.helperCompletedJobs(helper.getId())
        );

        model.addAttribute("reviewService", reviewService);

        return "helper/completed-jobs";   // ✅ DIFFERENT JSP
    }





    /* ================== PROFILE ================== */

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        model.addAttribute("helper", helper);
        model.addAttribute("categories", categoryService.getAll()); // ✅ ADD THIS

        return "helper/profile";
    }


    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute Helper helper,
                                @RequestParam("photo") MultipartFile photo,
                                HttpSession session)
            throws IOException {

        if (!photo.isEmpty()) {
            helper.setProfilePhoto(
                fileUploadService.saveFile(photo, "profile")
            );
        }

        Helper updated = helperService.update(helper);
        session.setAttribute("helper", updated);

        return "redirect:/helper/profile";
    }

    /* ================== AVAILABILITY (✅ INCLUDED) ================== */

    @PostMapping("/availability")
    public String toggleAvailability(HttpSession session) {

        Helper sessionHelper = (Helper) session.getAttribute("helper");
        if (sessionHelper == null) {
            return "redirect:/helper/login";
        }

        // 🔄 FETCH FRESH FROM DB
        Helper helper = helperService.getById(sessionHelper.getId());

        helper.setAvailable(!helper.isAvailable());
        Helper updated = helperService.update(helper);

        // 🔄 UPDATE SESSION
        session.setAttribute("helper", updated);

        // ✅ SHOW RESULT IMMEDIATELY
        return "redirect:/helper/jobs/available";
    }


    /* ================== LOGOUT ================== */

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/helper/login";
    }

    /* ================== REPLY TO REVIEW ================== */

    @PostMapping("/reply-review")
    public String reply(@RequestParam Long reviewId,
                        @RequestParam String reply) {

        Review review = reviewService.getById(reviewId);
        review.setHelperReply(reply);
        reviewService.save(review);

        return "redirect:/helper/dashboard";
    }
    
    @GetMapping("/revenue")
    public String yearlyRevenue(HttpSession session, Model model) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        int year = java.time.Year.now().getValue();

        List<Object[]> results =
                bookingService.helperYearlyRevenue(helper.getId(), year);

        // Prepare 12 months (Jan–Dec)
        double[] monthlyRevenue = new double[12];
        double total = 0;

        for (Object[] row : results) {
            int month = ((Number) row[0]).intValue(); // 1–12
            double amount = ((Number) row[1]).doubleValue();
            monthlyRevenue[month - 1] = amount;
            total += amount;
        }

        model.addAttribute("year", year);
        model.addAttribute("monthlyRevenue", monthlyRevenue);
        model.addAttribute("totalRevenue", total);

        return "helper/revenue";
    }
    
    @GetMapping("/warnings")
    public String warnings(HttpSession session, Model model) {

        Helper helper = (Helper) session.getAttribute("helper");
        model.addAttribute("warnings",
            helperWarningService.helperWarnings(helper.getId()));

        return "helper/warnings";
    }
    
    @PostMapping("/warnings/reply")
    public String replyWarning(@RequestParam Long warningId,
                               @RequestParam String reply,
                               HttpSession session) {

        Helper helper = (Helper) session.getAttribute("helper");
        if (helper == null) {
            return "redirect:/helper/login";
        }

        HelperWarning w = helperWarningService.getById(warningId);

        if (w != null && w.getHelper().getId().equals(helper.getId())) {
            w.setHelperReply(reply);
            helperWarningService.save(w);
        }

        return "redirect:/helper/warnings";
    }

}
