package in.sp.main.Services;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.SubscriptionUsage;
import in.sp.main.Entities.User;
import in.sp.main.Entities.UserSubscription;
import in.sp.main.Repositories.SubscriptionUsageRepository;
import in.sp.main.Repositories.UserSubscriptionRepository;

@Service
public class SubscriptionService {

    private final UserSubscriptionRepository userSubscriptionRepo;
    private final SubscriptionUsageRepository usageRepo;

    public SubscriptionService(UserSubscriptionRepository userSubscriptionRepo,
                               SubscriptionUsageRepository usageRepo) {
        this.userSubscriptionRepo = userSubscriptionRepo;
        this.usageRepo = usageRepo;
    }

    /* ================= CHECK ================= */

    public boolean hasActiveSubscription(
            User user,
            in.sp.main.Entities.Service service
    ) {

        return userSubscriptionRepo
                .findActiveSubscription(user.getId(), LocalDate.now())
                .flatMap(sub ->
                        usageRepo.findByUserSubscriptionAndService(sub, service)
                )
                .map(usage ->
                        usage.getUsedCount() < usage.getAllowedCount()
                )
                .orElse(false);
    }

    /* ================= CONSUME ================= */

    public void consumeService(
            User user,
            in.sp.main.Entities.Service service
    ) {

        UserSubscription sub =
                userSubscriptionRepo
                        .findActiveSubscription(user.getId(), LocalDate.now())
                        .orElseThrow();

        SubscriptionUsage usage =
                usageRepo
                        .findByUserSubscriptionAndService(sub, service)
                        .orElseThrow();

        usage.setUsedCount(usage.getUsedCount() + 1);
        usageRepo.save(usage);
    }

    /* ================= JSP HELPER ================= */

    public boolean isIncluded(Long userId, Long serviceId) {

        return userSubscriptionRepo
                .findActiveSubscription(userId, LocalDate.now())
                .map(sub ->
                        usageRepo.existsByUserSubscriptionIdAndServiceId(
                                sub.getId(),
                                serviceId
                        )
                )
                .orElse(false);
    }
    
    /* ================= DASHBOARD HELPER ================= */

    public UserSubscription getActiveSubscription(Long userId) {

        return userSubscriptionRepo
                .findActiveSubscription(userId, LocalDate.now())
                .orElse(null);
    }
    
    public List<SubscriptionUsage> getSubscriptionUsages(UserSubscription sub) {
        return usageRepo.findAll().stream()
                .filter(u -> u.getUserSubscription().getId().equals(sub.getId()))
                .toList();
    }


}
