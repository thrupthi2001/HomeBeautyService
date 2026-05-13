package in.sp.main.Services;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.User;
import in.sp.main.Repositories.UserRepository;

@Service
public class UserService {

    private final UserRepository repo;

    public UserService(UserRepository repo) {
        this.repo = repo;
    }

    public User register(User user) {
        return repo.save(user);
    }

    public User login(String email, String password) {
        return repo.findByEmailAndPassword(email, password).orElse(null);
    }
    
    public User update(User user) {
        return repo.save(user);
    }

}
