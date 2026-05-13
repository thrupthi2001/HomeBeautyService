package in.sp.main.Controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.Helper;
import in.sp.main.Entities.Review;
import in.sp.main.Entities.SubscriptionUsage;
import in.sp.main.Entities.User;
import in.sp.main.Entities.UserSubscription;
import in.sp.main.Services.BookingService;
import in.sp.main.Services.FileUploadService;
import in.sp.main.Services.ReviewService;
import in.sp.main.Services.ServiceService;
import in.sp.main.Services.ServiceStreakService;
import in.sp.main.Services.SubscriptionService;
import in.sp.main.Services.UserService;
import in.sp.main.Services.ServiceCategoryService;
import in.sp.main.Services.HelperService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final ServiceService serviceService;
    private final FileUploadService fileUploadService;
    private final BookingService bookingService;
    private final ReviewService reviewService;
    private final ServiceCategoryService categoryService;
    private final HelperService helperService;
    private final ServiceStreakService serviceStreakService;
    private final SubscriptionService subscriptionService;


    public UserController(UserService userService,
                          ServiceService serviceService,
                          FileUploadService fileUploadService,
                          BookingService bookingService,
                          ReviewService reviewService,
                          ServiceCategoryService categoryService,
                          HelperService helperService,
                          ServiceStreakService serviceStreakService,
                          SubscriptionService subscriptionService) {
        this.userService = userService;
        this.serviceService = serviceService;
        this.fileUploadService = fileUploadService;
        this.bookingService = bookingService;
        this.reviewService = reviewService;
        this.categoryService = categoryService;
        this.helperService = helperService;
        this.serviceStreakService = serviceStreakService;
        this.subscriptionService = subscriptionService;
    }

    /* ---------- REGISTER ---------- */

    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user,
                           @RequestParam("photo") MultipartFile photo)
            throws IOException {

        if (!photo.isEmpty()) {
            user.setProfilePhoto(
                fileUploadService.saveFile(photo, "profile")
            );
        }

        userService.register(user);
        return "redirect:/user/login";
    }

    /* ---------- LOGIN ---------- */

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session) {

        User user = userService.login(email, password);
        if (user == null) {
            return "redirect:/user/login";
        }

        session.setAttribute("user", user);
        return "redirect:/user/dashboard";
    }

    /* ---------- DASHBOARD ---------- */

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        // ================= BASIC DATA =================
        model.addAttribute("categories", categoryService.getAll());
        model.addAttribute("walletBalance",
                serviceStreakService.getWalletBalance(user.getId()));
        model.addAttribute("currentStreak",
                serviceStreakService.getCurrentStreak(user.getId()));

        // ================= SUBSCRIPTION =================
        UserSubscription sub =
                subscriptionService.getActiveSubscription(user.getId());

        if (sub != null) {

            long remainingDays = java.time.temporal.ChronoUnit.DAYS.between(
                    java.time.LocalDate.now(),
                    sub.getEndDate()
            );

            if (remainingDays < 0) remainingDays = 0;

            model.addAttribute("activeSubscription", sub);
            model.addAttribute("remainingDays", remainingDays);
        }

        return "user/dashboard";
    }
    
    @GetMapping("/category/{id}")
    public String servicesByCategory(@PathVariable Long id, Model model) {

        model.addAttribute("categories", categoryService.getAll());
        model.addAttribute("services", serviceService.getApprovedByCategory(id));
        model.addAttribute("reviewService", reviewService);

        return "user/category-services";
    }

    
    @GetMapping("/search")
    public String search(
            @RequestParam(required = false) String q,
            @RequestParam(required = false) Long categoryId,
            Model model) {

        model.addAttribute("services",serviceService.searchApproved(q, categoryId));
        model.addAttribute("reviewService", reviewService);

        return "user/search-results"; // ✅ NEW JSP
    }
    
    @GetMapping("/services")
    public String allServices(Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        model.addAttribute("services",
                serviceService.getByStatus("APPROVED"));
        model.addAttribute("reviewService", reviewService);
        model.addAttribute("subscriptionService", subscriptionService);
        model.addAttribute("user", user);

        return "user/services";
    }

    
    @GetMapping("/helper/{id}")
    public String viewHelperProfile(@PathVariable Long id, Model model) {

        Helper helper = helperService.getById(id);
        if (helper == null) {
            return "redirect:/user/bookings";
        }

        List<Review> reviews = reviewService.findAll();

        double avgHelperRating = reviews.stream()
            .filter(r -> r.getBooking() != null)
            .filter(r -> r.getBooking().getHelper() != null)
            .filter(r -> r.getBooking().getHelper().getId().equals(id))
            .filter(r -> r.getHelperRating() != null)
            .mapToInt(Review::getHelperRating)
            .average()
            .orElse(0.0);

        model.addAttribute("helper", helper);
        model.addAttribute("helperRating", avgHelperRating);

        return "user/helper-profile";
    }






    /* ---------- LOGOUT ---------- */

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/user/login";
    }
    
    @GetMapping("/bookings")
    public String myBookings(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");

        // 🔐 SAFETY CHECK
        if (user == null) {
            return "redirect:/user/login";
        }

        model.addAttribute(
            "bookings",
            bookingService.userBookings(user.getId())
        );
        
     // 👇 Needed for review button logic
        model.addAttribute("reviewService", reviewService);

        return "user/my-bookings";
    }

    
    /* ---------- USER PROFILE ---------- */

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/user/login";
        }

        model.addAttribute("user", user);
        return "user/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute User user,
                                @RequestParam("photo") MultipartFile photo,
                                HttpSession session)
            throws IOException {

        User sessionUser = (User) session.getAttribute("user");
        if (sessionUser == null) {
            return "redirect:/user/login";
        }

        // keep existing photo if not updated
        if (!photo.isEmpty()) {
            user.setProfilePhoto(
                fileUploadService.saveFile(photo, "profile")
            );
        } else {
            user.setProfilePhoto(sessionUser.getProfilePhoto());
        }

        User updated = userService.update(user);
        session.setAttribute("user", updated);

        return "redirect:/user/profile";
    }
    
    @GetMapping("/subscription/usage")
    public String subscriptionUsage(HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/user/login";
        }

        UserSubscription sub =
                subscriptionService.getActiveSubscription(user.getId());

        if (sub == null) {
            return "redirect:/user/dashboard";
        }

        List<SubscriptionUsage> usages =
                subscriptionService.getSubscriptionUsages(sub);

        model.addAttribute("subscription", sub);
        model.addAttribute("usages", usages);

        return "user/subscription-usage";
    }

    

}
