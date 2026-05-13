package in.sp.main.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import in.sp.main.Entities.User;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmailAndPassword(String email, String password);
}
