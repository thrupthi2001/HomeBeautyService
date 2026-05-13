package in.sp.main.Services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.Helper;
import in.sp.main.Services.ServiceStreakService;
import in.sp.main.Repositories.BookingRepository;

@Service
public class BookingService {

	private final BookingRepository repo;
	private final ServiceStreakService serviceStreakService;

	public BookingService(BookingRepository repo,
			ServiceStreakService serviceStreakService) {
		this.repo = repo;
		 this.serviceStreakService = serviceStreakService;
	}

	public void create(Booking booking) {
		booking.setStatus("BOOKED");
		booking.setCreatedAt(LocalDateTime.now());
		repo.save(booking);
	}

	public List<Booking> availableBookings() {
		return repo.findByStatus("BOOKED");
	}

	public void acceptBooking(Long bookingId, Helper helper) {
		Booking b = repo.findById(bookingId).orElseThrow();
		b.setHelper(helper);
		b.setStatus("ACCEPTED");
		repo.save(b);
	}

	public List<Booking> helperBookings(Long helperId) {
		return repo.findByHelperId(helperId);
	}

	public List<Booking> all() {
		return repo.findAll();
	}

	public List<Booking> userBookings(Long userId) {
	    return repo.findByUser_Id(userId);
	}


	public void cancelBooking(Long bookingId, Long userId) {

		Booking booking = repo.findById(bookingId).orElse(null);
		if (booking == null)
			return;

		// allow cancel only if not completed
		if (!"COMPLETED".equals(booking.getStatus())) {
			booking.setStatus("CANCELLED");
			booking.setHelper(null); // release helper if assigned
			repo.save(booking);
		}
	}
	
	public Booking getById(Long id) {
	    return repo.findById(id).orElse(null);
	}
	@Transactional
	public void updateStatus(Long bookingId, String newStatus) {

	    Booking booking = repo.findById(bookingId).orElseThrow();

	    String oldStatus = booking.getStatus();
	    booking.setStatus(newStatus);

	    repo.save(booking);

	    // ✅ TRIGGER STREAK ONLY ON FIRST COMPLETION
	    if (!"COMPLETED".equals(oldStatus) &&
	         "COMPLETED".equals(newStatus)) {

	        serviceStreakService.handleCompletedBooking(booking);
	    }
	}

	
	public List<Booking> findByStatus(String status) {
	    return repo.findByStatus(status);
	}
	
	public List<Booking> availableBookingsByCategory(Long categoryId) {
	    return repo.findByStatusAndService_Category_Id("BOOKED", categoryId);
	}
	
	public List<Booking> availableBookingsForHelper(Helper helper) {

	    // SAFETY CHECK
	    if (helper.getCategory() == null) {
	        return List.of(); // no jobs shown instead of crash
	    }

	    return repo.findAvailableForHelper(
	        helper.getCategory().getId(),
	        helper
	    );
	}

	
	// ================== HELPER DECLINE JOB ==================

	public void declineBooking(Long bookingId, Helper helper) {

	    Booking booking = repo.findById(bookingId).orElse(null);
	    if (booking == null) return;

	    // job should still be available to other helpers
	    booking.getDeclinedByHelpers().add(helper);

	    repo.save(booking);
	}
	
	public List<Booking> helperActiveJobs(Long helperId) {
	    return repo.findByHelperIdAndStatusIn(
	        helperId,
	        List.of("ACCEPTED", "ON_THE_WAY", "IN_PROGRESS")
	    );
	}

	public List<Booking> helperCompletedJobs(Long helperId) {
	    return repo.findByHelperIdAndStatus(
	        helperId,
	        "COMPLETED"
	    );
	}
     
	public List<Booking> helperCompletedBookings(Long helperId) {
	    return repo.findByHelperIdAndStatus(helperId, "COMPLETED");
	}
	
	public List<Object[]> helperYearlyRevenue(Long helperId, int year) {
	    return repo.yearlyRevenue(helperId, year);
	}



}
