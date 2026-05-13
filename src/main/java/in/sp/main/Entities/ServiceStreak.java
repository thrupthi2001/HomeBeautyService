package in.sp.main.Entities;

import java.time.LocalDateTime;

import jakarta.persistence.*;

@Entity
@Table(name = "service_streaks")
public class ServiceStreak {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 🔗 ONE STREAK PER USER
    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    // 🔢 consecutive completed services
    private int completedCount;

    // 💰 reward wallet (platform-funded)
    private double walletBalance;

    // ⏰ last completion time
    private LocalDateTime lastCompletedAt;

    /* ================= GETTERS & SETTERS ================= */

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getCompletedCount() {
        return completedCount;
    }

    public void setCompletedCount(int completedCount) {
        this.completedCount = completedCount;
    }

    public double getWalletBalance() {
        return walletBalance;
    }

    public void setWalletBalance(double walletBalance) {
        this.walletBalance = walletBalance;
    }

    public LocalDateTime getLastCompletedAt() {
        return lastCompletedAt;
    }

    public void setLastCompletedAt(LocalDateTime lastCompletedAt) {
        this.lastCompletedAt = lastCompletedAt;
    }
}
