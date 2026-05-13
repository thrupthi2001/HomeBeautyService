package in.sp.main.Services;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import in.sp.main.Entities.*;
import in.sp.main.Repositories.*;

@Service
public class UserSubscriptionService {

    private final UserSubscriptionRepository userSubRepo;
    private final SubscriptionPlanRepository planRepo;
    private final SubscriptionUsageRepository usageRepo;

    public UserSubscriptionService(
            UserSubscriptionRepository userSubRepo,
            SubscriptionPlanRepository planRepo,
            SubscriptionUsageRepository usageRepo
    ) {
        this.userSubRepo = userSubRepo;
        this.planRepo = planRepo;
        this.usageRepo = usageRepo;
    }

    /* ================= CHECK ================= */

    public boolean hasActiveSubscription(Long userId) {
        return userSubRepo
                .findActiveSubscription(userId, LocalDate.now())
                .isPresent();
    }

    public Optional<UserSubscription> getActiveSubscription(Long userId) {
        return userSubRepo.findActiveSubscription(userId, LocalDate.now());
    }

    /* ================= ACTIVATE ================= */

    @Transactional
    public void activateSubscription(User user, Long planId) {

        // 1️⃣ Expire existing active subscription (safety)
        userSubRepo
            .findActiveSubscription(user.getId(), LocalDate.now())
            .ifPresent(oldSub -> {
                oldSub.setStatus("EXPIRED");
                userSubRepo.save(oldSub);
            });

        // 2️⃣ Fetch plan
        SubscriptionPlan plan =
                planRepo.findById(planId)
                        .orElseThrow(() -> new RuntimeException("Plan not found"));

        // 3️⃣ Create new subscription
        UserSubscription sub = new UserSubscription();
        sub.setUser(user);
        sub.setSubscriptionPlan(plan);   // ✅ FIXED LINE
        sub.setStartDate(LocalDate.now());
        sub.setEndDate(LocalDate.now().plusDays(plan.getDurationDays()));
        sub.setStatus("ACTIVE");

        userSubRepo.save(sub);

        // 4️⃣ Create usage rows ONLY for included services
        for (SubscriptionPlanItem item : plan.getItems()) {

            if (item.getAllowedCount() <= 0) continue; // ✅ skip non-included

            SubscriptionUsage usage = new SubscriptionUsage();
            usage.setUserSubscription(sub);
            usage.setService(item.getService());
            usage.setAllowedCount(item.getAllowedCount());
            usage.setUsedCount(0);

            usageRepo.save(usage);
        }
    }
}
