package in.sp.main.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "subscription_usage")
public class SubscriptionUsage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_subscription_id", nullable = false)
    private UserSubscription userSubscription;

    @ManyToOne
    @JoinColumn(name = "service_id", nullable = false)
    private Service service;

    @Column(nullable = false)
    private int allowedCount;   // ✅ REQUIRED

    @Column(nullable = false)
    private int usedCount = 0;

    /* ---------- GETTERS & SETTERS ---------- */

    public Long getId() {
        return id;
    }

    public UserSubscription getUserSubscription() {
        return userSubscription;
    }

    public void setUserSubscription(UserSubscription userSubscription) {
        this.userSubscription = userSubscription;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }

    public int getAllowedCount() {        // ✅ THIS FIXES THE ERROR
        return allowedCount;
    }

    public void setAllowedCount(int allowedCount) {
        this.allowedCount = allowedCount;
    }

    public int getUsedCount() {
        return usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }
}
