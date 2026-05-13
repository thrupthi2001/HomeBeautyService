package in.sp.main.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import in.sp.main.Entities.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    Optional<Review> findByBookingId(Long bookingId);
    
    List<Review> findByServiceId(Long serviceId);

    List<Review> findByBooking_Helper_Id(Long helperId);


}
