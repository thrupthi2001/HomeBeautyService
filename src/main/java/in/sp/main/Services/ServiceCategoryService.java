package in.sp.main.Services;

import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.ServiceCategory;
import in.sp.main.Repositories.ServiceCategoryRepository;

@Service
public class ServiceCategoryService {

    private final ServiceCategoryRepository repo;

    public ServiceCategoryService(ServiceCategoryRepository repo) {
        this.repo = repo;
    }

    public List<ServiceCategory> getAll() {
        return repo.findAll();
    }

    public void save(ServiceCategory category) {
        repo.save(category);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }
}
