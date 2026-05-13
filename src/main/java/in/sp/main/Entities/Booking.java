package in.sp.main.Entities;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.*;

@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customerName;
    private String customerPhone;
    private String customerAddress;
    private String completionPhoto;

    private LocalDate serviceDate;
    private LocalTime serviceTime;
    private LocalDateTime createdAt;

    // 💰 PRICING (NEW)
    private Double originalPrice;   // helper payout
    private Double walletUsed;      // discount from wallet
    private String paymentMode;     // COD / ONLINE

    @ManyToOne
    private Service service;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToMany
    @JoinTable(
        name = "booking_declined_helpers",
        joinColumns = @JoinColumn(name = "booking_id"),
        inverseJoinColumns = @JoinColumn(name = "helper_id")
    )
    private Set<Helper> declinedByHelpers = new HashSet<>();

    @ManyToOne
    private Helper helper;

    private String status;

    /* ================= FORMATTED DATE ================= */
    @Transient
    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        return createdAt.format(
            DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a")
        );
    }

    /* ================= GETTERS & SETTERS ================= */

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }

    public LocalDate getServiceDate() { return serviceDate; }
    public void setServiceDate(LocalDate serviceDate) { this.serviceDate = serviceDate; }

    public LocalTime getServiceTime() { return serviceTime; }
    public void setServiceTime(LocalTime serviceTime) { this.serviceTime = serviceTime; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public Double getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(Double originalPrice) { this.originalPrice = originalPrice; }

    public Double getWalletUsed() { return walletUsed; }
    public void setWalletUsed(Double walletUsed) { this.walletUsed = walletUsed; }

    public String getPaymentMode() { return paymentMode; }
    public void setPaymentMode(String paymentMode) { this.paymentMode = paymentMode; }

    public Service getService() { return service; }
    public void setService(Service service) { this.service = service; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Helper getHelper() { return helper; }
    public void setHelper(Helper helper) { this.helper = helper; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCompletionPhoto() { return completionPhoto; }
    public void setCompletionPhoto(String completionPhoto) { this.completionPhoto = completionPhoto; }

    public Set<Helper> getDeclinedByHelpers() { return declinedByHelpers; }
    public void setDeclinedByHelpers(Set<Helper> declinedByHelpers) {
        this.declinedByHelpers = declinedByHelpers;
    }
}
