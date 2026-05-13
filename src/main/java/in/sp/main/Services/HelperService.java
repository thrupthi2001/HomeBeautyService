package in.sp.main.Services;

import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.Helper;
import in.sp.main.Repositories.HelperRepository;

@Service
public class HelperService {

    private final HelperRepository repo;

    public HelperService(HelperRepository repo) {
        this.repo = repo;
    }

    public Helper register(Helper helper) {
        return repo.save(helper);
    }

    public Helper login(String phone, String password) {
        return repo.findByPhoneAndPassword(phone, password).orElse(null);
    }

    public Helper update(Helper helper) {
        return repo.save(helper);
    }

    public Helper getById(Long id) {
        return repo.findById(id).orElse(null);
    }
    public List<Helper> getAll() {
        return repo.findAll();
    }
    
    public void deleteById(Long id) {
        repo.deleteById(id);
    }

}
