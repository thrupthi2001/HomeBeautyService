package in.sp.main.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import in.sp.main.Services.BookingService;
import in.sp.main.Services.ReviewService;

@Controller
@RequestMapping("/admin/bookings")
public class AdminBookingController {

    private final BookingService bookingService;
    private final ReviewService reviewService;

    public AdminBookingController(
            BookingService bookingService,
            ReviewService reviewService) {

        this.bookingService = bookingService;
        this.reviewService = reviewService;
    }

    // 🔹 ALL BOOKINGS
    @GetMapping
    public String list(Model model) {
        model.addAttribute("bookings", bookingService.all());
        return "admin/booking-list";
    }

    // 🔹 VIEW BOOKING DETAILS
    @GetMapping("/{id}")
    public String view(@PathVariable Long id, Model model) {

        var booking = bookingService.getById(id);
        model.addAttribute("booking", booking);

        // only load review if completed
        if ("COMPLETED".equals(booking.getStatus())) {
            model.addAttribute(
                "review",
                reviewService.findByBookingId(id).orElse(null)
            );
        }

        return "admin/booking-details";
    }
}
