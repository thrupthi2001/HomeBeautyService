package in.sp.main.Services;

import java.time.LocalDateTime;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import in.sp.main.Entities.Booking;
import in.sp.main.Entities.ServiceStreak;
import in.sp.main.Entities.User;
import in.sp.main.Repositories.ServiceStreakRepository;

@Service
@Transactional
public class ServiceStreakService {

    private final ServiceStreakRepository repo;

    private static final int STREAK_TARGET = 3;
    private static final double REWARD_AMOUNT = 200.0;

    public ServiceStreakService(ServiceStreakRepository repo) {
        this.repo = repo;
    }

    private ServiceStreak getOrCreate(User user) {

        return repo.findByUser_Id(user.getId())
            .orElseGet(() -> {
                ServiceStreak s = new ServiceStreak();
                s.setUser(user);
                s.setCompletedCount(0);
                s.setWalletBalance(0.0);
                return repo.save(s);
            });
    }

    public void handleCompletedBooking(Booking booking) {

        if (booking.getUser() == null) return;

        ServiceStreak streak = getOrCreate(booking.getUser());

        streak.setCompletedCount(streak.getCompletedCount() + 1);
        streak.setLastCompletedAt(LocalDateTime.now());

        if (streak.getCompletedCount() >= STREAK_TARGET) {
            streak.setWalletBalance(streak.getWalletBalance() + REWARD_AMOUNT);
            streak.setCompletedCount(0);
        }

        repo.save(streak);
    }
    /* =====================================================
       WALLET
       ===================================================== */

    public double getWalletBalance(Long userId) {
        return repo.findByUser_Id(userId)
                .map(ServiceStreak::getWalletBalance)
                .orElse(0.0);
    }

    public void consumeWallet(Long userId, double amount) {

        ServiceStreak streak = repo.findByUser_Id(userId).orElse(null);
        if (streak == null) return;

        streak.setWalletBalance(
            Math.max(0, streak.getWalletBalance() - amount)
        );
        repo.save(streak);
    }

    public int getCurrentStreak(Long userId) {
        return repo.findByUser_Id(userId)
                .map(ServiceStreak::getCompletedCount)
                .orElse(0);
    }
}
