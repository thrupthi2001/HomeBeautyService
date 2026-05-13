package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import in.sp.main.Entities.ServiceImage;

public interface ServiceImageRepository extends JpaRepository<ServiceImage, Long> {
}
