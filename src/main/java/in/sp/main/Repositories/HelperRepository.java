package in.sp.main.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import in.sp.main.Entities.Helper;

public interface HelperRepository extends JpaRepository<Helper, Long> {

    Optional<Helper> findByPhoneAndPassword(String phone, String password);
}
