package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import in.sp.main.Entities.ServiceCategory;

public interface ServiceCategoryRepository
        extends JpaRepository<ServiceCategory, Long> {
}
