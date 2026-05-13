package in.sp.main.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.SubscriptionUsage;
import in.sp.main.Entities.UserSubscription;

public interface SubscriptionUsageRepository
        extends JpaRepository<SubscriptionUsage, Long> {

    Optional<SubscriptionUsage> findByUserSubscriptionAndService(
            UserSubscription userSubscription,
            in.sp.main.Entities.Service service
    );

    boolean existsByUserSubscriptionIdAndServiceId(
            Long userSubscriptionId,
            Long serviceId
    );
}
