package in.sp.main.Entities;

import jakarta.persistence.*;

@Entity
@Table(name = "subscription_plan_items")
public class SubscriptionPlanItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "plan_id")
    private SubscriptionPlan subscriptionPlan;

    @ManyToOne
    @JoinColumn(name = "service_id")
    private Service service;

    private int allowedCount;

    /* ===== GETTERS & SETTERS ===== */

    public Long getId() { return id; }

    public SubscriptionPlan getSubscriptionPlan() {
        return subscriptionPlan;
    }

    public void setSubscriptionPlan(SubscriptionPlan subscriptionPlan) {
        this.subscriptionPlan = subscriptionPlan;
    }

    public Service getService() { return service; }
    public void setService(Service service) { this.service = service; }

    public int getAllowedCount() { return allowedCount; }
    public void setAllowedCount(int allowedCount) {
        this.allowedCount = allowedCount;
    }
}
