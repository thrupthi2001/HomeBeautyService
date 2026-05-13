package in.sp.main.Controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.HelperReport;
import in.sp.main.Entities.Review;
import in.sp.main.Entities.User;
import in.sp.main.Services.BookingService;
import in.sp.main.Services.FileUploadService;
import in.sp.main.Services.HelperReportService;
import in.sp.main.Services.ReviewService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {

    private final ReviewService reviewService;
    private final BookingService bookingService;
    private final FileUploadService fileUploadService;
    private final HelperReportService helperReportService;

    public ReviewController(ReviewService reviewService,
                            BookingService bookingService,
                            FileUploadService fileUploadService,
                            HelperReportService helperReportService) {
        this.reviewService = reviewService;
        this.bookingService = bookingService;
        this.fileUploadService = fileUploadService;
        this.helperReportService = helperReportService;
    }

    /* ========= SHOW REVIEW PAGE ========= */
    @GetMapping("/add/{bookingId}")
    public String add(@PathVariable Long bookingId, Model model) {

        Booking booking = bookingService.getById(bookingId);

        if (!"COMPLETED".equals(booking.getStatus())) {
            return "redirect:/user/bookings";
        }

        model.addAttribute("booking", booking);
        return "review/add-review";
    }

    /* ========= SUBMIT REVIEW ========= */
    @PostMapping("/submit")
    public String submit(
    		@RequestParam int serviceRating,
            @RequestParam int helperRating,
            @RequestParam String comment,
            @RequestParam Long bookingId,
            @RequestParam("photo") MultipartFile photo,
            @RequestParam(required = false) boolean reportHelper,
            @RequestParam(required = false) String reportReason,
            HttpSession session) throws IOException {

        User user = (User) session.getAttribute("user");
        Booking booking = bookingService.getById(bookingId);

        if (booking == null || user == null) {
            return "redirect:/user/bookings";
        }

        Review review = new Review();
        review.setServiceRating(serviceRating);
        review.setHelperRating(helperRating);
        review.setComment(comment);
        review.setBooking(booking);
        review.setService(booking.getService());
        review.setUser(user);

        if (!photo.isEmpty()) {
            review.setReviewPhoto(
                fileUploadService.saveFile(photo, "review_image")
            );
        }

        reviewService.save(review);
        if (reportHelper) {
            HelperReport report = new HelperReport();
            report.setHelper(booking.getHelper());
            report.setUser(user);
            report.setReview(review);
            report.setReason(reportReason);

            helperReportService.report(report);
        }


        return "redirect:/user/bookings";
    }

    
    @GetMapping("/view/{bookingId}")
    public String viewReview(@PathVariable Long bookingId, Model model) {

        Review review = reviewService
                .findByBooking(bookingId);

        if (review == null) {
            return "redirect:/user/bookings";
        }

        model.addAttribute("review", review);
        return "review/view-review";
    }

}
