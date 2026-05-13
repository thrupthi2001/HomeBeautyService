package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;

import in.sp.main.Entities.SubscriptionPlan;

public interface SubscriptionPlanRepository
        extends JpaRepository<SubscriptionPlan, Long> {

    List<SubscriptionPlan> findByStatus(String status);

    // 🔥 IMPORTANT: fetch items + services in ONE query
    @Query("""
        SELECT DISTINCT p
        FROM SubscriptionPlan p
        LEFT JOIN FETCH p.items i
        LEFT JOIN FETCH i.service
    """)
    List<SubscriptionPlan> findAllWithItems();

    @Query("""
        SELECT DISTINCT p
        FROM SubscriptionPlan p
        LEFT JOIN FETCH p.items i
        LEFT JOIN FETCH i.service
        WHERE p.status = :status
    """)
    List<SubscriptionPlan> findByStatusWithItems(@Param("status") String status);
}
