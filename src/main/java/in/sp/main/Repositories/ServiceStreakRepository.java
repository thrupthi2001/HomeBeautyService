package in.sp.main.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.ServiceStreak;

public interface ServiceStreakRepository
        extends JpaRepository<ServiceStreak, Long> {

    Optional<ServiceStreak> findByUser_Id(Long userId);
}
