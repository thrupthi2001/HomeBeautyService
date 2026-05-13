package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.Helper;

public interface BookingRepository extends JpaRepository<Booking, Long> {

    List<Booking> findByStatus(String status);

    List<Booking> findByHelperId(Long helperId);
    
    List<Booking> findByUser_Id(Long userId);
    List<Booking> findByStatusAndService_Category_Id(String status, Long categoryId);
    
    @Query("""
    		SELECT b FROM Booking b
    		WHERE b.status = 'BOOKED'
    		AND b.service.category.id = :categoryId
    		AND :helper NOT MEMBER OF b.declinedByHelpers
    		""")
    		List<Booking> findAvailableForHelper(
    		    @Param("categoryId") Long categoryId,
    		    @Param("helper") Helper helper
    		);
    
    List<Booking> findByHelperIdAndStatusIn(
            Long helperId,
            List<String> statuses
    );

    List<Booking> findByHelperIdAndStatus(
            Long helperId,
            String status
    );
    
    @Query("""
    	    SELECT MONTH(b.createdAt), SUM(b.service.price)
    	    FROM Booking b
    	    WHERE b.helper.id = :helperId
    	      AND b.status = 'COMPLETED'
    	      AND YEAR(b.createdAt) = :year
    	    GROUP BY MONTH(b.createdAt)
    	""")
    	List<Object[]> yearlyRevenue(
    	        @Param("helperId") Long helperId,
    	        @Param("year") int year
    	);


}
