package in.sp.main.Repositories;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.Service;


public interface ServiceRepository extends JpaRepository<Service, Long> {

    List<Service> findByStatus(String status);
    
    List<Service> findByStatusAndCategory_Id(String status, Long categoryId);

    List<Service> findByStatusAndTitleContainingIgnoreCase(String status, String keyword);

    List<Service> findByStatusAndTitleContainingIgnoreCaseAndCategory_Id(
            String status, String title, Long categoryId);
    
    List<Service> findByHelper_Id(Long helperId);
    long countByHelper_Id(Long helperId);



}

