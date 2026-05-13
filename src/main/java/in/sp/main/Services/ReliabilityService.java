package in.sp.main.Services;

import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.Review;

@Service
public class ReliabilityService {

    public double calculateHelperScore(
            List<Booking> bookings,
            List<Review> reviews,
            Long helperId
    ) {

        long accepted = bookings.stream()
                .filter(b -> b.getHelper() != null)
                .filter(b -> b.getHelper().getId().equals(helperId))
                .filter(b -> !b.getStatus().equals("CANCELLED"))
                .count();

        long completed = bookings.stream()
                .filter(b -> b.getHelper() != null)
                .filter(b -> b.getHelper().getId().equals(helperId))
                .filter(b -> b.getStatus().equals("COMPLETED"))
                .count();

        long cancelled = bookings.stream()
                .filter(b -> b.getHelper() != null)
                .filter(b -> b.getHelper().getId().equals(helperId))
                .filter(b -> b.getStatus().equals("CANCELLED"))
                .count();

        double completionRate = accepted == 0 ? 0 : (double) completed / accepted;

        double avgRating = reviews.stream()
                .filter(r -> r.getBooking() != null)
                .filter(r -> r.getBooking().getHelper() != null)
                .filter(r -> r.getBooking().getHelper().getId().equals(helperId))
                .filter(r -> r.getHelperRating() != null)
                .mapToInt(Review::getHelperRating)
                .average()
                .orElse(0.0);

        double score =
                (completionRate * 50) +
                ((avgRating / 5) * 30) -
                (cancelled * 2);

        return Math.max(0, Math.min(100, score));
    }
}
