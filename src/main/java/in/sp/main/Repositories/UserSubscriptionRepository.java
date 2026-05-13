package in.sp.main.Repositories;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import in.sp.main.Entities.UserSubscription;

public interface UserSubscriptionRepository
        extends JpaRepository<UserSubscription, Long> {

    @Query("""
        SELECT us FROM UserSubscription us
        WHERE us.user.id = :userId
          AND us.startDate <= :today
          AND us.endDate >= :today
          AND us.status = 'ACTIVE'
    """)
    Optional<UserSubscription> findActiveSubscription(
            @Param("userId") Long userId,
            @Param("today") LocalDate today
    );
    
    // ✅ REQUIRED FOR ADMIN VIEW USERS PAGE
    List<UserSubscription> findBySubscriptionPlanId(Long planId);
}
