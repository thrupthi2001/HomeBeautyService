package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import in.sp.main.Entities.SubscriptionPlanItem;

public interface SubscriptionPlanItemRepository
        extends JpaRepository<SubscriptionPlanItem, Long> {
}
