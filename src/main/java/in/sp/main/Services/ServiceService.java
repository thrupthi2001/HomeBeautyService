package in.sp.main.Services;

import java.util.List;
import org.springframework.stereotype.Service;
import in.sp.main.Repositories.ServiceRepository;


@Service
public class ServiceService {

    private final ServiceRepository repo;

    public ServiceService(ServiceRepository repo) {
        this.repo = repo;
    }

    public List<in.sp.main.Entities.Service> getAll() {
        return repo.findAll();
    }

    public void save(in.sp.main.Entities.Service service) {
        repo.save(service);
    }

    public in.sp.main.Entities.Service getById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public void delete(Long id) {
        repo.deleteById(id);
    }
    
 // ✅ FIXED METHOD
    public List<in.sp.main.Entities.Service> getByStatus(String status) {
        return repo.findByStatus(status);
    }
    
    public List<in.sp.main.Entities.Service> getApprovedByCategory(Long categoryId) {
        return repo.findByStatusAndCategory_Id("APPROVED", categoryId);
    }

    public List<in.sp.main.Entities.Service> searchApproved(String keyword, Long categoryId) {

        if (keyword != null && categoryId != null) {
            return repo.findByStatusAndTitleContainingIgnoreCaseAndCategory_Id(
                    "APPROVED", keyword, categoryId);
        }

        if (keyword != null) {
            return repo.findByStatusAndTitleContainingIgnoreCase(
                    "APPROVED", keyword);
        }

        if (categoryId != null) {
            return repo.findByStatusAndCategory_Id(
                    "APPROVED", categoryId);
        }

        return repo.findByStatus("APPROVED");
    }
    
    public List<in.sp.main.Entities.Service> getByHelper(Long helperId) {
        return repo.findByHelper_Id(helperId);
    }



}
