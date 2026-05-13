package in.sp.main.Entities;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "subscription_plans")
public class SubscriptionPlan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private double price;

    private int durationDays; // ex: 30

    private String status; // ACTIVE / INACTIVE

    private LocalDate createdAt = LocalDate.now();

    @OneToMany(
    	    mappedBy = "subscriptionPlan",
    	    cascade = CascadeType.ALL,
    	    fetch = FetchType.LAZY
    	)
    	private List<SubscriptionPlanItem> items;

    /* ===== GETTERS & SETTERS ===== */

    public Long getId() { return id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<SubscriptionPlanItem> getItems() { return items; }
    public void setItems(List<SubscriptionPlanItem> items) { this.items = items; }
}
