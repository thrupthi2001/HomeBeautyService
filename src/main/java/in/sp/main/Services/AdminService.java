package in.sp.main.Services;

import org.springframework.stereotype.Service;
import in.sp.main.Entities.Admin;
import in.sp.main.Repositories.AdminRepository;

@Service
public class AdminService {

    private final AdminRepository repo;

    public AdminService(AdminRepository repo) {
        this.repo = repo;
    }

    public Admin register(Admin admin) {
        return repo.save(admin);
    }

    public Admin login(String email, String password) {
        return repo.findByEmailAndPassword(email, password).orElse(null);
    }

    public Admin update(Admin admin) {
        return repo.save(admin);
    }
}
