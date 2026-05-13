package in.sp.main.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.User;
import in.sp.main.Services.BookingService;
import in.sp.main.Services.ServiceService;
import in.sp.main.Services.ServiceStreakService;
import in.sp.main.Services.SubscriptionService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/booking")
public class BookingController {

    private final BookingService bookingService;
    private final ServiceService serviceService;
    private final ServiceStreakService streakService;
    private final SubscriptionService subscriptionService;

    public BookingController(BookingService bookingService,
                             ServiceService serviceService,
                             ServiceStreakService streakService,
                             SubscriptionService subscriptionService) {
        this.bookingService = bookingService;
        this.serviceService = serviceService;
        this.streakService = streakService;
        this.subscriptionService = subscriptionService;
    }

    @GetMapping("/{serviceId}")
    public String bookPage(@PathVariable Long serviceId, Model model) {
        model.addAttribute("service",
                serviceService.getById(serviceId));
        return "booking/book";
    }
    
    /* ================= PREVIEW (CONFIRM PAGE) ================= */

    @PostMapping("/preview")
    public String preview(@ModelAttribute Booking booking,
                          HttpSession session,
                          Model model) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        var service = serviceService.getById(booking.getService().getId());
        
        boolean isSubscriptionService =
                subscriptionService.hasActiveSubscription(user, service);

        if (isSubscriptionService) {

            booking.setOriginalPrice(0.0);
            booking.setWalletUsed(0.0);

            model.addAttribute("booking", booking);
            model.addAttribute("service", service);
            model.addAttribute("subscriptionApplied", true);
            model.addAttribute("walletBalance", 0);
            model.addAttribute("walletUsable", 0);
            model.addAttribute("payableAmount", 0);

            return "booking/confirm";
        }


        double walletBalance = streakService.getWalletBalance(user.getId());
        double originalPrice = service.getPrice();

        // wallet preview (UI only)
        double walletUsable = Math.min(walletBalance, originalPrice);
        double payableAmount = originalPrice - walletUsable;

        booking.setOriginalPrice(originalPrice);
        booking.setWalletUsed(0.0); // real deduction happens on confirm

        model.addAttribute("booking", booking);
        model.addAttribute("service", service);
        model.addAttribute("walletBalance", walletBalance);
        model.addAttribute("walletUsable", walletUsable);
        model.addAttribute("payableAmount", payableAmount);

        return "booking/confirm";
    }


    /* ================= FINAL CONFIRM ================= */

    @PostMapping("/confirm")
    public String confirm(@ModelAttribute Booking booking,
                          @RequestParam(required = false) Boolean useWallet,
                          @RequestParam(required = false) String paymentMode,
                          HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";

        // ================= SUBSCRIPTION BOOKING =================
        if (subscriptionService.hasActiveSubscription(user, booking.getService())) {

            booking.setUser(user);
            booking.setPaymentMode("SUBSCRIPTION");
            booking.setWalletUsed(0.0);
            booking.setOriginalPrice(0.0);

            bookingService.create(booking);
            subscriptionService.consumeService(user, booking.getService());

            return "booking/success";
        }

        // ================= NORMAL BOOKING =================
        booking.setUser(user);

        // safety default
        if (paymentMode == null) {
            paymentMode = "ONLINE";
        }
        booking.setPaymentMode(paymentMode);

        if (Boolean.TRUE.equals(useWallet)) {
            double wallet = streakService.getWalletBalance(user.getId());
            double usable = Math.min(wallet, booking.getOriginalPrice());

            booking.setWalletUsed(usable);
            streakService.consumeWallet(user.getId(), usable);
        } else {
            booking.setWalletUsed(0.0);
        }

        bookingService.create(booking);
        return "booking/success";
    }


    
    @PostMapping("/cancel")
    public String cancelBooking(@RequestParam Long bookingId,
                                HttpSession session) {

        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/user/login";
        }

        bookingService.cancelBooking(bookingId, user.getId());
        return "redirect:/user/bookings";
    }




}
