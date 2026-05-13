package in.sp.main.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.*;
import in.sp.main.Repositories.ReviewRepository;

@Service
public class ReviewService {

    private final ReviewRepository repo;

    public ReviewService(ReviewRepository repo) {
        this.repo = repo;
    }

    public boolean alreadyReviewed(Long bookingId) {
        return repo.findByBookingId(bookingId).isPresent();
    }

    public void submitReview(Review review) {
        repo.save(review);
    }
    
 // ✅ SAVE REVIEW (FIXES ERROR)
    public void save(Review review) {
        repo.save(review);
    }
    
    public Review getById(Long id) {
        return repo.findById(id).orElse(null);
    }

    // (Already needed later – safe to keep)
    public List<Review> findByService(Long serviceId) {
        return repo.findByServiceId(serviceId);
    }
    
    public List<Review> findAll() {
        return repo.findAll();
    }
    
    public Review findByBooking(Long bookingId) {
        return repo.findByBookingId(bookingId).orElse(null);
    }
    
    public double getAverageServiceRating(Long serviceId) {
        List<Review> reviews = repo.findByServiceId(serviceId);

        if (reviews.isEmpty()) return 0.0;

        double avg = reviews.stream()
                .filter(r -> r.getServiceRating() != null)
                .mapToInt(Review::getServiceRating)
                .average()
                .orElse(0.0);

        return Math.round(avg * 10.0) / 10.0; // 1 decimal
    }
    
    public double getAverageHelperRating(Long helperId) {
        List<Review> reviews = repo.findByBooking_Helper_Id(helperId);

        if (reviews.isEmpty()) return 0.0;

        double avg = reviews.stream()
                .filter(r -> r.getHelperRating() != null)
                .mapToInt(Review::getHelperRating)
                .average()
                .orElse(0.0);

        return Math.round(avg * 10.0) / 10.0; // 1 decimal
    }
    
    public Optional<Review> findByBookingId(Long bookingId) {
        return repo.findByBookingId(bookingId);
    }





}
